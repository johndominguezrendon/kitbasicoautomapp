// This shows a simple build wrapper example, using the AnsiColor plugin.
	
	pipeline { 
		agent any
		triggers { pollSCM('* * * * *') }
		stages {
			stage('Build') { 
				steps { 
					bat "build.bat"
					
				}
			}
			stage('Analisis de c�digo') { 
				steps { 
					bat "anali_code.bat"
					
				}
			}
			stage('Deploy') { 
				steps { 
					bat "deploy.bat"
				}
			}		
		}
		
	}

