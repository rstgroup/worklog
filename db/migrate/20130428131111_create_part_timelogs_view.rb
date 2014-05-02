class CreatePartTimelogsView < ActiveRecord::Migration
  def change
    create_view :part_timelogs, %Q(
      SELECT SUM(timelogs.duration) AS duration, accounts.id AS account_id, parts.id AS part_id FROM timelogs
      INNER JOIN users ON users.id = timelogs.user_id
      INNER JOIN parts ON parts.id = timelogs.part_id
      INNER JOIN accounts ON accounts.id = users.account_id WHERE accounts.id = 2
      GROUP BY parts.id HAVING duration >= 0
    ), force: true
  end
end
