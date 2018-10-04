require "rails_helper"

RSpec.describe "Todos API", type: :request do
  let!(:todos) {create_list(:todo, 10)}
  let(:todo_id) {todos.first.id}

  describe "GET /todos" do
    before {get todos_path}

    it "returns todos" do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it "returns status code 200" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET /todos/:id" do
    before {get todo_path(id: todo_id)}

    context "when the record exists" do
      it "returns the todo" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(todo_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status 200
      end
    end
  end

  describe "POST /todos" do
    let(:valid_attributes) {{title: "Learn Elm", created_by: "1"}}

    context "when the request is valid" do
      before {post todos_path, params: valid_attributes}

      it "creates a todo" do
        expect(json["title"]).to eq("Learn Elm")
      end

      it "returns status code 201" do
        expect(response).to have_http_status 201
      end
    end

    context "when the request is invalid" do
      before {post todos_path, params: {title: "Foobar"}}

      it "returns status code 422" do
        expect(response).to have_http_status 422
      end

      it "returns a validation failure message" do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe "PUT /todos/:id" do
    let(:valid_attributes) {{title: "Shopping"}}

    context "when the record exists" do
      before {put todo_path(id: todo_id), params: valid_attributes}

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status 204
      end
    end
  end

  describe "DELETE /todos/:id" do
    before {delete todo_path(id: todo_id)}

    it "returns status code 204" do
      expect(response).to have_http_status 204
    end
  end
end
