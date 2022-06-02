class AddGlossaryItemsToTranslations < ActiveRecord::Migration[7.0]
  def change
    add_column :translations, :glossary_items, :text, array: true, default: []
  end
end
