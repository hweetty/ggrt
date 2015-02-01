var express		= require("express");
var app			= express();
var fs			= require("fs");
var http			= require("http");
var Q				= require("q");

var BASE_URL  = "http://realtimemap.grt.ca/";

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

app.get ("/v1/getAllRoutes", function (req, res) {
	res.send ({
		status: 200,
		message: "ok",
		routes: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","19","20","21","22","23","24","25","27","29","31","33","51","52","53","54","55","56","57","58","59","60","61","62","63","64","67","72","73","75","76","92","110","111","116","200","201","202","203","9801","9851","9852","9901","9903","9904","9905","9931","9932","9951_merged_1004188369","9952","9953","9954","9961","9963","9964","9983"]
	});
});

app.get ("/v1/GetStopsForRoute", function (req, res) {
    var params = req.query;
    if (params.routeId == null) {
        res.send ({
            status: 400,
            message: "Unspecified routeId"
        });
    }
    else {
    	_getStopsForRouteInfo(params.routeId, res);
    }
});

function _getStopsForRouteInfo (routeId, res) {
	var url = BASE_URL + "Stop/GetByRouteId?routeId=" + routeId;
	httpGet(url).then(function (data) {
		data = "{\"stops\": " + data + "}";
		console.log(data);
		var json = JSON.parse(data);
		console.log(json);
		res.send ({
			status: 200,
			stops: json.stops
		});
	})
}

app.get ("/v1/latestVersion", function (req, res) {
    res.send ({
    	status: 200,
    	latestVersion: "0.6"
    })
});

app.use(function(req, res) {
	res.redirect("https://github.com/hweetty/ggrt");
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
