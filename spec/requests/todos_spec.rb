require "rails_helper"

RSpec.describe "Todos API", type: :request do
  let(:user) {create(:user)}
  let!(:todos) {create_list(:todo, 10)}
  let(:todo_id) {todos.first.id}
  # authorize request
  let(:headers) {valid_headers}

  describe "GET /todos" do
    before {get todos_path, params: {}, headers: headers}

    it "returns todos" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET /todos/:id" do
    before {get todo_path(id: todo_id), params: {}, headers: headers}

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
    let(:valid_attributes) do
      # send json payload
      { title: 'Learn Elm', created_by: user.id.to_s }.to_json
    end

    context "when the request is valid" do
      before {post todos_path, params: valid_attributes, headers: headers}

      it "creates a todo" do
        expect(json["title"]).to eq("Learn Elm")
      end

      it "returns status code 201" do
        expect(response).to have_http_status 201
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { title: nil }.to_json }
      before {post todos_path, params: invalid_attributes, headers: headers}

      it "returns status code 422" do
        expect(response).to have_http_status 422
      end

      it "returns a validation failure message" do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe "PUT /todos/:id" do
    let(:valid_attributes) {{title: "Shopping"}.to_json}

    context "when the record exists" do
      before {put todo_path(id: todo_id), params: valid_attributes, headers: headers}

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status 204
      end
    end
  end

  describe "DELETE /todos/:id" do
    before {delete todo_path(id: todo_id), params: {}, headers: headers}

    it "returns status code 204" do
      expect(response).to have_http_status 204
    end
  end
end
