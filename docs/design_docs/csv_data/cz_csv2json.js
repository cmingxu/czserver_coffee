/*
 * cz_csv2json.js
 * Maintaince Logs: ------------------
 * Waigo    2013-01-08     Initial version.
 * 
 * 
*/


var csv = require('csv')
    , fs = require('fs')
    , path = require('path')



var CSV2Json = function(file_name){
	csv()
	.from.stream(fs.createReadStream(__dirname + '/' + file_name))
	.to.path(__dirname + '/export/' + path.basename(file_name, '.csv') + '.json' )
	//.to(console.log)
	.on('end', function() { console.log(file_name + 'is done.'); })
	.transform(function(data, index){
		if (index > 2)
		{
			console.log(JSON.stringify(data));
			return JSON.stringify(data);
		}
	});
}


// Bootstrap all csv_files
var csv_files = fs.readdirSync(__dirname)


csv_files.forEach( function(file_name){
	var file_path = __dirname + '/' + file_name

	console.log(path.extname(file_path));
	if(path.extname(file_path) == '.csv') 
	{
		CSV2Json(file_name);
	}
});

