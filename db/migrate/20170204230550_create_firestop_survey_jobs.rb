class CreateFirestopSurveyJobs < ActiveRecord::Migration
  def change
    create_table :firestop_survey_jobs do |t|

      t.timestamps null: false
    end
  end
end
