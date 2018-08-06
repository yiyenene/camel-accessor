class User < ActiveRecord::Base
  camel_accessor
end

class Book < ActiveRecord::Base
  camel_accessor_to(:random_code)
end

class Drink < ActiveRecord::Base
  camel_lower_letter
  camel_accessor
end

RSpec.describe CamelAccessor do
  it "has a version number" do
    expect(CamelAccessor::VERSION).not_to be nil
  end

  describe ".camel_accessor" do
    let(:user) { User.create(value2: 100) }
    it "writer pass to snake_case writer" do
      user.TestValue = "test"
      expect(user.test_value).to eq("test")
    end

    it "reader read from snake_case reader" do
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

  describe ".camel_lower_letter" do
    let(:drink) { Drink.create(type_id: "abc") }

    it "reader read from snake_case reader" do
      expect(drink.typeId).to eq("abc")
    end

    it "writer pass to snake_case writer" do
      drink.typeId = "def"
      expect(drink.type_id).to eq("def")
    end
  end
end
