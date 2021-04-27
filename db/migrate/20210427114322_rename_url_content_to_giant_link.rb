class RenameUrlContentToGiantLink < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls, :url_content, :giant_link
  end
end
