3.times { Post.create!(title: 'Sample Post', firstContent: 'Sample Content') }
2.times { Post.create!(title: 'Sample Post', firstContent: 'Sample Content', secondContent: 'Sample Content') }
