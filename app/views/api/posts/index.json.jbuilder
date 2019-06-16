json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :title, :firstContent, :secondContent, :thirdContent, :forthContent, :fifthContent, :rname, :is_display, :status, :created_at, :updated_at
  end
end
