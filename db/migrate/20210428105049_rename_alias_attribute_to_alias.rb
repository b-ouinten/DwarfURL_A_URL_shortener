class RenameAliasAttributeToAlias < ActiveRecord::Migration[5.2]
  def change
    rename_column :urls, :alias, :_alias
  end
end
