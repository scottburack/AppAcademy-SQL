require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns.nil?
      @columns = DBConnection.execute2(<<-SQL)
        SELECT
         *
        FROM
        '#{table_name}'

      SQL
      @columns = @columns.first.map {|col|col.to_sym}

    else
      @columns

    end
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |arg|
        self.attributes[col] = arg
      end


    end
  end

  def self.table_name=(table_name)
     @table_name = table_name
  end

  def self.table_name
    @table_name = self.to_s.tableize unless @table_name
    @table_name
  end

  def self.all
    table = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
      "#{table_name}"

    SQL
    parse_all(table)
  end

  def self.parse_all(results)
    results.map {|all| self.new(all)}
  end

  def self.find(id)
    table = DBConnection.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = :id

    SQL
    parse_all(table).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      send("#{attr_name}=", value)

    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    #
    # self.attributes.fetch_values

  end

  def insert
    debugger
    col_names = self.columns.join(',')
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
