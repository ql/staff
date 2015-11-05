var app = angular.module('myApp', ['ngResource', 'ngRoute', 'ngTagsInput']);

app.factory('Skill', ['$resource', function($resource) {
  return $resource('/skills/:id', 
                    null, {
      'update':   { method:'PUT'}, 
      'complete': { method: 'GET', url: 'skills/complete', isArray: true}
  });
}]);

app.factory('Position', ['$resource', function($resource) {
  return $resource('/positions/:id', null, {
    'update': { method:'PUT'},
    'matches': { method: 'GET', isArray: true}
  });
}]);

app.factory('Applicant', ['$resource', function($resource) {
  return $resource('/applicants/:id', null, {
    'update': { method:'PUT'},
    'matches': { method: 'GET', url: 'applicants/:id/matches', isArray: true}
  });
}]);


app.config(['$routeProvider', function($routeProvider) {
   $routeProvider.
     when('/viewSkills', {
        templateUrl: 'viewSkills.htm', controller: 'ViewSkillsController'
     }).
     when('/editSkill/:id', {
        templateUrl: 'editSkill.htm', controller: 'EditSkillController'
     }).
     when('/editPosition/:id', {
        templateUrl: 'editPosition.htm', controller: 'EditPositionController'
     }).
     when('/editPosition', {
        templateUrl: 'editPosition.htm', controller: 'EditPositionController'
     }).
     when('/viewPositions', {
        templateUrl: 'viewPositions.htm', controller: 'ViewPositionsController'
     }).
     when('/viewApplicants/:id/viewMatches', {
        templateUrl: 'viewPositionsMatched.htm', controller: 'MatchedPositionsController'
     }).
     when('/viewApplicants', {
        templateUrl: 'viewApplicants.htm', controller: 'ViewApplicantsController'
     }).
     when('/editApplicants/:id', {
        templateUrl: 'editApplicant.htm', controller: 'EditApplicantController'
     }).
     when('/editApplicants/', {
        templateUrl: 'editApplicant.htm', controller: 'EditApplicantController'
     }).
     when('/viewMatchedPositions', {
        templateUrl: 'viewMatchedPositions.htm', controller: 'MatchedPositionsController'
     }).
   otherwise({
      redirectTo: '/viewPositions' //#TODO
   });
	
}]);

app.controller('ViewSkillsController', ['$scope', 'Skill', '$location', function($scope, Skill, $location) {
    $scope.skills = Skill.query();
    $scope.skill = new Skill();
    $scope.errors = {};

    $scope.addSkill = function() {
      $scope.skill.$save(null, 
        function() {
          $location.path('/viewSkills/');
          $('#newSkillModal').modal('hide');
        },
        function(response) {
          angular.forEach(response.data, function(value, key) {
            $scope.errors[key] = key + ' ' + value;
          });
          $scope.has_errors = true;
        }
      );
      
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
        function(httpResponse) {alert('Unable to delete');} //err
      );
    };

    $scope.deleteSkill = function(skill) {
      if (confirm("Please confirm deleting skill")) {
        Skill.delete({id: skill.id});
        $scope.viewSkills();
      }
    };




}]);

app.controller('ViewPositionsController', ['$scope', 'Position', '$location', function($scope, Position, $location) {
  $scope.positions = Position.query();
  
  $scope.addPosition = function() {
    $location.path('/addPosition/');
  };

  $scope.editPosition = function(id) {
    $location.path('/editPosition/'+id); //hack 
  };
}]);

app.controller('EditPositionController', ['$scope', 'Position', 'Skill', '$routeParams', '$location', function($scope, Position, Skill, $routeParams, $location) {
  if ($routeParams.id) {
    $scope.position = Position.get({id: $routeParams.id});
    $scope.savePosition = function(position) {
      Position.update(
        {id: position.id},
        position,
        function() { $location.path('/viewPositions/'); },
        function() { alert("Server error :("); }
      );
    };
  } else {
    $scope.position = new Position();
    $scope.savePosition = function(position) {
      position.$save(null, 
        function() { $location.path('/viewPositions/'); },
        function() { alert("Server error :("); }
      );
    };
  }

  $scope.loadSkills = function(query) {
    return Skill.complete({query: query}).$promise;
  };
}]);

app.controller('ViewApplicantsController', ['$scope', 'Applicant', '$location', function($scope, Applicant, $location) {
  $scope.applicants = Applicant.query();
  
  $scope.addApplicant = function() {
    $location.path('/editApplicant/');
  };

  $scope.editApplicant = function(id) {
    $location.path('/editApplicant/'+id); //hack 
  };

  $scope.viewMatches = function(id) {
    $location.path('/viewApplicants/'+id+ '/viewMatches'); //hack 
  };
}]);

app.controller('EditApplicantController', ['$scope', 'Applicant', 'Skill', '$routeParams', '$location', function($scope, Applicant, Skill, $routeParams, $location) {
  if ($routeParams.id) {
    $scope.applicant = Applicant.get({id: $routeParams.id});
    $scope.saveApplicant = function(applicant) {
      Applicant.update(
        {id: applicant.id},
        applicant,
        function() { $location.path('/viewApplicants/'); },
        function() { alert("Server error :("); }
      );
    };
  } else {
    $scope.applicant = new Applicant();
    $scope.applicant.status = "searching";
    $scope.saveApplicant = function(applicant) {
      applicant.$save(
        null,
        null,
        function() { $location.path('/viewApplicants/'); },
        function() { alert("Server error :("); }
      );
    };
  }
  $scope.applicants = Applicant.query();
  
  $scope.addApplicant = function() {
    $location.path('/editApplicants/');
  };

  $scope.editApplicant = function(id) {
    $location.path('/editApplicants/'+id); //hack 
  };

  $scope.loadSkills = function(query) {
    return Skill.complete({query: query}).$promise;
  };


}]);
app.controller('MatchedPositionsController', ['$scope', 'Applicant', 'Skill', '$routeParams', '$location', function($scope, Applicant, Skill, $routeParams, $location) {
  $scope.applicant = Applicant.get({id: $routeParams.id});
  $scope.positions = Applicant.matches({id: $routeParams.id});
}]);
