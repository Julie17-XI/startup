require "employee" #why not require_relative './employee.rb'

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name=name
        @funding=funding
        @salaries=salaries
        @employees=[]
    end

    def valid_title?(string)
        if @salaries.has_key?(string)
            return true
        else
            return false
        end
    end

    def >(startup)
        if @funding>startup.funding
            true
        else
            false
        end
    end
    
    def hire(employee_name,title)
        if self.valid_title?(title)
            employee=Employee.new(employee_name,title)
            @employees<<employee
        else
            raise "invalid title"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary=@salaries[employee.title]
        if @funding>salary
            employee.pay(salary)
            @funding-=salary
        else
            raise "not enough funding"
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        total=0
        size=@employees.length
        @employees.each do |employee|
            total+=@salaries[employee.title]
        end
        total/size
    end

    def close
        @employees=[]
        @funding=0
    end

    def acquire(startup)
        @funding+=startup.funding
        @salaries=startup.salaries.merge(@salaries)
        @employees+=startup.employees
        startup.close
    end
end
