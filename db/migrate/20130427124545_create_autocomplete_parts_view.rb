class CreateAutocompletePartsView < ActiveRecord::Migration
  def change
    create_view :autocomplete_parts, %Q(
      SELECT CONCAT(c.name, ' - ', pj.name, ' - ', p.name) as calculated_name, p.id AS part_id, c.account_id AS account_id FROM clients AS c
      JOIN projects AS pj ON  pj.client_id = c.id
      JOIN parts AS p ON p.project_id = pj.id
    ), force: true
  end
end
