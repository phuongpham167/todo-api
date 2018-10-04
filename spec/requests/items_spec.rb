require "rails_helper"

RSpec.describe "Items API", type: :request do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  describe "GET /todos/:todo_id/items" do
    before {get todo_items_path(todo_id: todo_id), params: {}, headers: headers }

    context "when show success" do
      it{expect(response).to have_http_status 200}
      it{expect(json.size).to eq 20}
    end
  end

  describe "GET /todos/:todo_id/items/:id" do
    before {get todo_item_path(todo_id: todo_id, id: id), params: {}, headers: headers }

    context "when show todo item success" do
      it{expect(response).to have_http_status 200}
      it{expect(json["id"]).to eq(id)}
    end

    context "when todo item does not exist" do
      let(:id) {0}
      it{expect(response).to have_http_status 404}
      it{expect(response.body).to match(/Couldn't find Item/)}
    end
  end

  describe "POST /todos/:todo_id/items" do
    let(:valid_attributes) {{name: "Visit Narnia", done: false}.to_json}

    context "when request attributes are valid" do
      before {post todo_items_path(todo_id: todo_id), params: valid_attributes, headers: headers }

      it{expect(response).to have_http_status 201}
    end

    context "when an invalid request" do
      before {post todo_items_path(todo_id: todo_id), params: {}, headers: headers }

      it{expect(response).to have_http_status 422}

      it{expect(response.body).to match(/Validation failed: Name can't be blank/)}
    end
  end

  describe "PUT /todos/:todo_id/items/:id" do
    let(:valid_attributes) {{ name: "Mozart" }.to_json}

    before {put todo_item_path(todo_id: todo_id, id: id), params: valid_attributes, headers: headers }

    context "when item exists" do
      it{expect(response).to have_http_status 204}
      it "updates the item" do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context "when item does not exist" do
      let(:id) {0}

      it{expect(response).to have_http_status 404}
      it{expect(response.body).to match(/Couldn't find Item/)}
    end
  end

  describe "DELETE /todos/:id" do
    before {delete todo_item_path(todo_id: todo_id, id: id), params: {}, headers: headers}

    it{expect(response).to have_http_status 204}
  end
end
