# frozen_string_literal: true

class AssociateStepsToBranches < Ductwork::Migration
  def change
    options = if postgresql?
                {
                  type: uuid_column_type,
                  index: true,
                  null: true,
                  foreign_key: { to_table: :ductwork_branches },
                }
              else
                {
                  type: uuid_column_type,
                  limit: 36,
                  index: true,
                  null: true,
                  foreign_key: { to_table: :ductwork_branches },
                }
              end

    add_reference :ductwork_steps, :branch, **options
  end
end
