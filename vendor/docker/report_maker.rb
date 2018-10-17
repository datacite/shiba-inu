
require 'json'
require 'date'


FILENAME = "../../tmp/output.json"


def get_datasets
  datasets = File.readlines(FILENAME).map do |line|
    JSON.parse line.gsub('=>', ':')
  end
  datasets
end

def make_report
  logdate= "2018-04-05"
  report = {
    "report-header": get_header(logdate),
    "report-datasets": get_datasets
  }
  File.open("../../tmp/DataCite-access.log-_#{logdate}.json","w") do |f|
    f.write(report.to_json)
  end
end

def get_header logdate
 date = Date.parse(logdate)
 {
  "report-name": "dataset report",
    "report-id": "dsr",
    "release": "rd1",
    "created": Date.today,
    "created-by": "datacite",
    "reporting-period": 
    {
        "begin-date": Date.civil(date.year, date.mon, 1).strftime("%Y-%m-%d"),
        "end-date": Date.civil(date.year, date.mon, -1).strftime("%Y-%m-%d")
    },
    "report-filters": [ ],
    "report-attributes": [ ],
    "exceptions": [ ]
  }
end

make_report