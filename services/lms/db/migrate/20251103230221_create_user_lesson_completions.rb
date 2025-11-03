class CreateUserLessonCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :user_lesson_completions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :lesson, null: false, foreign_key: true, type: :uuid
      t.datetime :completed_at
      t.boolean :is_completed, default: false

      t.timestamps
    end
  end
end
