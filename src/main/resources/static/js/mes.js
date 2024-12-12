angular.module('myApp', [])
  .controller('NotificationController', ['$scope', '$websocket', function($scope, $websocket) {
    $scope.message = '';

    var ws = $websocket('ws://localhost:8080/ws');

    ws.onOpen(function() {
      console.log('WebSocket connected');
      ws.send(JSON.stringify({ type: 'connect' }));
    });

    ws.onMessage(function(message) {
      console.log('Received message:', message.data);
    });

    $scope.sendNotification = function() {
      ws.send(JSON.stringify({ type: 'notification', message: $scope.message }));
      $scope.message = '';
    };
  }]);