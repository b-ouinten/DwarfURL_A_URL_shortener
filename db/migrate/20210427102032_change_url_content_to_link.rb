class ChangeUrlContentToLink < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls, :url_content, :link
  end
end
