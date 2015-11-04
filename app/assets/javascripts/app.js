var app = angular.module('myApp', ['ngResource', 'ngRoute']);

app.factory('Skill', ['$resource', function($resource) {
  return $resource('/skills/:id', null, {'update': { method:'PUT'}});
}]);


app.config(['$routeProvider', function($routeProvider) {
   $routeProvider.
     when('/viewSkills', {
        templateUrl: 'viewSkills.htm', controller: 'ViewSkillsController'
     }).
     when('/editSkill/:id', {
        templateUrl: 'editSkill.htm', controller: 'EditSkillController'
     }).
   otherwise({
      redirectTo: '/viewSkills' //#TODO
   });
	
}]);

app.controller('ViewSkillsController', ['$scope', 'Skill', '$location', function($scope, Skill, $location) {
    $scope.skills = Skill.query();

    $scope.skill = new Skill();
    $scope.addSkill = function() {
      $scope.skill.$save();
      $location.path('/viewSkills/');
      $('#newSkillModal').modal('hide');
    };

    $scope.editSkill = function(skill) {
      $location.path('/editSkill/'+skill.id);
    };
}]);

app.controller('EditSkillController', ['$scope', 'Skill', '$routeParams', '$location', function($scope, Skill, $routeParams, $location) {
    $scope.skill = Skill.get({id: $routeParams.id});
    $scope.newName = null;

    $scope.viewSkills = function() {
      $location.path('/viewSkills/');
    };

    $scope.renameSkill = function(skill, newName) {
      skill.name = newName;
      Skill.update(
        {id: skill.id},
        skill, 
        null, 
        function(httpResponse) {alert('cannot');} //err
      );
    };

    $scope.deleteSkill = function(skill) {
      if (confirm("Please confirm deleting skill")) {
        Skill.delete({id: skill.id});
        $scope.viewSkills();
      }
    };


}]);
