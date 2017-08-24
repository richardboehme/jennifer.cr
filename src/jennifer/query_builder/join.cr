module Jennifer
  module QueryBuilder
    class Join
      @type : Symbol
      property table : String, type, on : Condition | LogicOperator, aliass : String?, relation : String?

      def initialize(@table, on : Criteria, @type, @aliass = nil, @relation = nil)
        @on = on.to_condition
      end

      def initialize(@table, @on : Condition | LogicOperator, @type, @aliass = nil, @relation = nil)
      end

      def to_sql
        sql_string =
          case @type
          when :left
            "LEFT JOIN "
          when :right
            "RIGHT JOIN "
          else
            "JOIN "
          end
        sql_string +
          if @aliass
            "#{@table} #{@aliass} ON #{@on.to_sql}\n"
          else
            "#{@table} ON #{@on.to_sql}\n"
          end
      end

      def alias_tables(aliases)
        @aliass = aliases[@relation.as(String)] if @relation && !@aliass
        @on.alias_tables(aliases)
      end

      def sql_args
        @on.sql_args
      end

      def sql_args_count
        @on.sql_args_count
      end
    end
  end
end
