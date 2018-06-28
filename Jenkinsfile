// This shows a simple build wrapper example, using the AnsiColor plugin.
	
	@Library("DeployProduction") _
	
	pipeline { 
		agent any
		triggers { pollSCM('* * * * *') }
		
		stages {

			node {
            stage('Compile') {
            // First variant
            gradle {
            tasks: 'clean'
            tasks: 'compileJava'
        }

            // Second variant
             gradle tasks: 'clean'
             gradle tasks: 'compileJava'

            // Third variant
            gradle('clean')
            gradle('compileJava')
    }
}
			
		
			stage('Probar unitariamente') { 
				steps {
                                        script { 
                                        if (isUnix()) {
										 sh 'cd KitBasicoAutomApp/'	  
										 sh 'gradle build --info'              
                                        } else {         
                                                 bat "test.bat"      
                                        }
                                        }	
				}
			}
		
			
/*			stage('Analisis de c�digo') { 
				steps { 
					withSonarQubeEnv('SonarQubeLocal') {
						bat 'anali_code.bat'
					}
					
				}
			}
			
			stage('Verificar calidad t�cnica') { 
				steps { 
					script{					
					timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
						def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
						if (qg.status != 'OK') {
						  error "Pipeline aborted due to quality gate failure: ${qg.status}"
						}
					}
					}
				}
			}
*/			
			stage('Generar desplegable') { 
				steps { 
					powershell 'wget http://localhost:8090/shutdown'
					powershell 'wget http://localhost:8091/shutdown'
					bat "build.bat"
					
				}
			}
			
			stage('Desplegar Integraci�n') { 
				steps { 
					bat "deploy-bd.bat"
					bat "deploy-app.bat"
					archiveArtifacts artifacts: 'KitBasicoAutomApp/*.txt', excludes: 'output/*.md'
				}
			}
/*
			stage('Versionar'){
				steps {
					script{
						// Obtain an Artifactory server instance, defined in Jenkins --> Manage:
						def server = Artifactory.server 'Jenkins-Local'

						def uploadSpec = """{
						  "files": [
							{
							  "pattern": "*.jar",
							  "target": "kit-basico-repository"
							}
						 ]
						}"""
						def buildInfo2=server.upload(uploadSpec)
						
						server.publishBuildInfo buildInfo2
		
					}
				}
			}
*/	
/*

		
			stage('Desplegar Pruebas') { 
				steps { 
				
					script{	
										
*/
//						checkout([$class: 'GitSCM', 
//						branches: [[name: '*/master']], 
/*						doGenerateSubmoduleConfigurations: false, 
						extensions: [[$class: 'RelativeTargetDirectory', 
							relativeTargetDir: 'KitBasicoAutomApp-Ops']], 
						submoduleCfg: [], 
						userRemoteConfigs: [[url: 'https://github.com/mauro2357/KitBasicoAutomApp-Ops.git']]])     
			      }
					bat 'mkdir "KitBasicoAutomApp/build/libs/config"'
					bat 'xcopy "KitBasicoAutomApp-Ops/config" "KitBasicoAutomApp/build/libs/config"'
					bat "deploy-bd.bat"
					bat "deploy-app.bat"
					archiveArtifacts artifacts: 'KitBasicoAutomApp/*.txt', excludes: 'output/*.md'
				}
			}
*/
/*			
			stage('Desplegar producci�n'){
				steps { 
					 script { 
						standardPipeline.deploy 'http://produccion.com'
						
					}
				}
			}
			
		}
		
*/	
}		
		post {
			failure {
				mail to: 'mauro2357@gmail.com',
					subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
					body: "Something is wrong with ${env.BUILD_URL}"
			}
			
			always {
				// Let's wipe out the workspace before we finish!
				deleteDir()
			}
		}
		
}



