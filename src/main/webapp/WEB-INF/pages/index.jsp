<!DOCTYPE html>
<html ng-app="koc">
<head lang="en">
	<meta charset="UTF-8"/>
	<title></title>
	<link rel="stylesheet" href="/resources/css/foundation.css"/>
	<script src="/resources/js/angular.js"></script>
	<script src="/resources/js/ngDialog.js"></script>
	<script src="/resources/js/jquery.js"></script>
	<script src="/resources/js/jquery.mask.js"></script>
	<script type="text/javascript" src="//www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>

	<link rel="stylesheet" href="/resources/css/ngDialog-theme-default.css">
</head>
<body>
<div class="row" ng-controller="MainCtrl">
	<div class="columns large-6 large-centered ">

		<input ng-model="firstName" type="text" placeholder="User First Name" required/>
		<input ng-model="surname" type="text" placeholder="User Surname" required/>
		<input ng-model="telephone" class="phone" type="text" placeholder="Telephone" required/>
		<a ng-click="ekle()" class="right button round"><b>Ekle</b></a>
		<table>
			<thead>
			<tr>
				<th>User First Name</th>
				<th>User Surname</th>
				<th>Telephone</th>
				<th>Delete</th>
			</tr>
			</thead>
			<tbody>
			<tr ng-repeat="user in users">
				<td>{{user.firstName}}</td>
				<td>{{user.surname}}</td>
				<td>{{user.telephone}}</td>
				<td><span class="label round" ng-click="DeletePrompt(user)">Delete</span></td>
				<td><span class="label round" ng-click="ShowNgDialog(user)">Update</span></td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
<script>

	$(document).ready(function() {
		$('.phone').focus(function() {
			$('.phone').mask("(999)999-9999");
		});
		$('.phone').blur(function() {
			$(this).val("");
			$(this).mask("(999)999-9999");
		});

	});




</script>
<script>
	var kocModule = angular.module("koc", ['ngDialog']);



	kocModule.controller("MainCtrl", ["$scope","$http","ngDialog","$window", function ($scope,$http,ngDialog,$window) {




		$scope.ShowNgDialog = function (user) {
			$scope.user=user;
			ngDialog.open({
				template: '<table>' +
				'<tr><input type="text" ng-model="user.firstName" code="user.firstName"/></tr>' +
				'<tr><input type="text" ng-model="user.surname" code="user.surname" /></tr>' +
				'<tr><input type="text" id="phone2" ng-model="user.telephone" code="user.telephone" /></tr>' +
				'<tr><td><span class="label round" ng-click="update(user)">Update</span></tr></td>'+
				'<div vc-recaptcha key="targettarget" ></div>'+
				'</table>',
				plain: true,
				scope:$scope
			});

		}

		$scope.delete = function(user){
			var id =user.id;

			$http.delete('/delete/'+id)
					.success(function (data) {
						var users = $scope.users;
						users.splice(users.indexOf(user),1);
					})

		}

		$scope.DeletePrompt = function (user) {
			var retVal = confirm("Do you want to delete the user?");
			if (retVal == true) {
				$scope.delete(user).
						success(function (data, status, headers, config) {
							alert('Deleted');
						}).error(function (data, status, headers, config) {
							alert('Error while deleting');
						});
				return true;
			} else {
				return false;
			}
		}

		$http.get('/all')
				.success(function (data) {
					$scope.users = data;
				}).error(function () {
					console.log("Error occured..");
				});


		$scope.alertUpdate = function(user) {
			$window.alert("Update Success : "+ user.firstName +" "+ user.surname +" "+ user.telephone );
		};

		$scope.update = function(){
			$http.put('/save',$scope.user)
					.success(function (user) {
						$scope.alertUpdate(user);
					})
		}

		$scope.ekle = function () {
			var user = {
				firstName: $scope.firstName,
				surname: $scope.surname,
				telephone: $scope.telephone
			}

			$http.post('/save', user)
					.success(function (user) {
						$scope.users.push(user);
					})

		}




	}]);

</script>
</body>
</html>