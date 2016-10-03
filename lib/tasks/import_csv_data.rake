require 'csv'
namespace :import_sales_engine_csv do
  task :create_sales_engine_data => :environment do
    
    csv_text = File.read('...')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Moulding.create!(row.to_hash)
    end
  end
end
