var express		= require("express");
var app			= express();
var fs			= require("fs");
var http			= require("http");
var Q				= require("q");

var BASE_URL  = "http://realtimemap.grt.ca/";

// app.use(function(req, res) {
//         res.redirect("/index.html");
// });

var server = app.listen(1729);
console.log("Server started");


app.get ("/v1/GetStopInfo", function (req, res) {
    var params = req.query;
    if (params.routeId == null || params.stopId == null) {
        res.send ({
            status: 400,
            message: "Unspecified routeId or StopId"
        });
    }
    else {
    	_getStopInfo(params.routeId, params.stopId, res);
    }
});

function _getStopInfo (routeId, stopId, res) {
	var url = BASE_URL + "Stop/GetStopInfo?routeId=" + routeId + "&stopId=" + stopId;
	httpGet(url).then(function (data) {
		var json = JSON.parse(data);
		if (json.status != "success") {
			res.send ({
				status: 500,
				message: "Unable to get data from GRT"
			});
			return;
		}

		console.log(json);
		res.send (json.stopTimes[0]);
	})
}

app.get ("/v1/latestVersion", function (req, res) {
    res.send ({
    	status: 200,
    	latestVersion: "0.6"
    })
});

var httpGet = function (url) {
	console.log(url);
   var deferred = Q.defer();
   http.get(url, deferred.resolve);
   return deferred.promise.then(loadBody);
};

var loadBody = function (res) {
   var deferred = Q.defer();
   var body = "";
   res.on("data", function (chunk) {
       body += chunk;
   });
   res.on("end", function () {
       deferred.resolve(body);
   });
   return deferred.promise;
};
