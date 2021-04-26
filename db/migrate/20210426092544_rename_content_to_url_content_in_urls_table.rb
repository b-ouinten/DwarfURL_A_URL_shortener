class RenameContentToUrlContentInUrlsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls, :content, :url_content
  end
end
