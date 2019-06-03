pipeline {
  agent { label 'devwin' }
  stages {
    stage('Setup') {
      steps {
        powershell('''chef shell-init powershell''')
        powershell('''echo "Versions:"''')
        powershell('''chef --version''')
        powershell('''rubocop --version''')
        powershell('''foodcritic --version''')
        powershell('''echo "Updating Berkshelf:"
        If (Test-Path -Path Policyfile.rb) {chef install Policyfile.rb --chef-license accept} Else {"File not found"}'''
        // Line 17 has been set up to run policyfile as an example use next line for berks.
        // If (Test-Path -Path Berksfile.lock) {berks install) Else {berks update}
        )
      }
    }
  
stage('Acceptance Testing') {
      steps {
            parallel(
              Rubocop: {
            powershell('''echo "Starting chefstyle (rubocop): "''')
            powershell('''rubocop --color''')
              },
              FoodCritic: {
            powershell('''echo "Starting foodcritic: "''')
            powershell('''foodcritic . --tags -FC078''')
              },
              ChefSpec: {
            powershell('''echo Starting ChefSpec: ''')
            powershell('''chef exec rspec''')
              }
            )
          }
        }
      
    stage('Test Kitchen') {
      steps {
        sh 'kitchen test -d always --color'
      }
    }
  }


  post {
    success {
      echo "Berks Upload"
     }
    failure {
      echo "The build failed"
    }
  }
}
    // stage('Merge to master') {
    //    when {
    //      expression {
    //        return env.BRANCH_NAME != 'dev';
    //        }
    //       }
    //       steps{
    //       powershell('''git push -o merge_request.create''')
    //       }
    //      }
    //     stage('Merge and push to chef-server') {
    //         when {
    //      expression {
    //        return env.BRANCH_NAME != 'master';
    //        }
    //       }
    //       steps{
    //           // plan is to come back and add logic for copying the starterkit into a chef-repo and moving the workingdir for berks or policyfile magic.
    //             // input message: 'All tests Passed, pushing to chef'
    //             powershell('''echo berks install''') 
    //             powershell('''echo berks upload''')
    //         }
    //       } 


    // stage('Deployment') {
    //   if (env.BRANCH_NAME == 'dev') {
    //     // node('devwin') {
    //   // stage('Merge to master') {
    //     input message: 'All tests passed. Creating merge request.'
    //       powershell('''git push -o merge_request.create -o merge_request.target=master''')
    //       } else { 
    //     stage('Merge and push to chef-server') {
    //           // plan is to come back and add logic for copying the starterkit into a chef-repo and moving the workingdir for berks or policyfile magic.
    //             input message: 'All tests Passed, pushing to chef'
    //             powershell('''echo berks install''') 
    //             powershell('''echo berks upload''')
    //         }
    //       }
    //     }
