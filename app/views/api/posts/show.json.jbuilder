json.set! :post do
  json.extract! @post, :id, :title, :firstContent, :secondContent, :thirdContent, :forthContent, :fifthContent, :rname, :is_display, :status, :created_at, :updated_at
end
