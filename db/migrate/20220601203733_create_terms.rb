class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms do |t|
      t.string :source_term
      t.string :target_term

      t.belongs_to :glossary

      t.timestamps
    end
  end
end
