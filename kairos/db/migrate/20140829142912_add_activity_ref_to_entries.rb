class AddActivityRefToEntries < ActiveRecord::Migration
  def change
    add_reference :entries, :activity, index: true
  end
end
