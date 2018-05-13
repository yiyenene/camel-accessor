class User < ActiveRecord::Base
  camel_accessor
end

class Book < ActiveRecord::Base
  camel_accessor_to(:random_code)
end

RSpec.describe CamelAccessor do
  it "has a version number" do
    expect(CamelAccessor::VERSION).not_to be nil
  end

  describe ".camel_accessor" do
    let(:user) { User.create(value2: 100) }
    it "setter pass to snake_case setter" do
      user.TestValue = "test"
      expect(user.test_value).to eq("test")
    end

    it "getter read from snake_case getter" do
      expect(user.Value2).to eq(100)
    end
  end

  describe ".camel_accessor_to" do
    let(:book) { Book.create(random_code: "abc") }
    it "accessor defined with passed attribute" do
      book.RandomCode = "fff"
      expect(book.RandomCode).to eq("fff")
    end

    it "accessor not defined with other attribute" do
      expect { book.RegistrationNumber }.to raise_error(NoMethodError)
    end
  end
end
