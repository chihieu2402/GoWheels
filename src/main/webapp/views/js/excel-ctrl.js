/*var app = angular.module('app', []);
app.controller("ctrl", function($scope, $http){
    $scope.import = function(files){	
        var reader = new FileReader();
        reader.onloadend = async () => {
            var workbook = new ExcelJS.Workbook();
            await workbook.xlsx.load(reader.result);
            const worksheet = workbook.getWorksheet('Sheet1');
            worksheet.eachRow((row, index) => {
                if (index > 1) {
                    let account = {
                        // lay tu excel ra o day
                        userName: row.getCell(1).value,
                        passWord: row.getCell(2).value ? row.getCell(2).value.toString() : 'aaa'
                    }
                    var url = "http://localhost:8080/rest/account";
                    $http.post(url, account).then(response => {
                        console.log("success", response.data);
                       location.reload();
                    }).catch(error => {
                        console.log("Error", error);
                    })


                    }
                
            });
        };
        reader.readAsArrayBuffer(files[0]);
    }
})*/