
namespace :srj do

    desc "Import nataff into database"
    task nataffs: :environment do
        file = File.read("#{Rails.root}/nataffs.json")
        nataffs = JSON.parse(file)

        nataffs.each do |nataff|
            nataff['created_at'] = DateTime.now
            nataff['updated_at'] = DateTime.now
        end

        Nataff.upsert_all(nataffs, unique_by: [:code])
    end

    desc "import natinf into database"
    task natinfs: :environment do
    end
end