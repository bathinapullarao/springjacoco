
//#!groovy
node
{
 stage('declareEnvVariables')
	{
        def dockerHome = tool 'myDocker'
        def mavenHome  = tool 'myMaven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
        }
	stage('gitCheckout') 
	{
        checkout scm
    	}  
  
	stage('Sonar')
    {
           try 
           {
            sh "mvn clean install sonar:sonar -P sonar"
            } 
	         catch(error)
	          {
            echo "The sonar server could not be reached ${error}"
            }
     } 
	
	
/*        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    // Requires SonarQube Scanner for Jenkins 2.7+
                    waitForQualityGate abortPipeline: true
                }
            }
        }
	
	
	stage('SonarQube analysis') 
	{
    		withSonarQubeEnv('My SonarQube Server') 
		{
      		// requires SonarQube Scanner for Maven 3.2+
      		sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.0:sonar'
    		}
  	}
	
	
	stage('Maven Install') 
      {
        sh 'mvn clean install'
      }   */
    stage('Docker Build') 
    {
       sh 'docker build -t bathinapullarao/spring-petclini:latest .'
    }
    stage('Docker Push') 
    {
       withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
          {
            sh "docker login -u $env.USERNAME -p $env.PASSWORD"
            sh "docker push bathinapullarao/spring-petclini:latest"
            echo "Image push complete"
          }
     }
  /* stage('Sonar')
    {
           try 
           {
            sh "mvn sonar:sonar sonar-break:sonar-break"
            } 
	         catch(error)
	          {
            echo "The sonar server could not be reached ${error}"
            }
     }   
 
	stage('unitTest')
	{
        try {
            sh "mvn test" 
	          } 
        catch(error)
	          {
            echo "The Maven can not perform Junit ${error}"
            }
   }

*/    
stage('approvalofQA')
	  {
    input "Deploy to QA?"
    	  }
    node {
	    slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script {
                    try  {
                        timeout(time:01, unit:'MINUTES') 
			    {
                            env.APPROVE_QA = input message: 'Deploy to QA', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_QA', choices: 'YES\nNO', description: 'Deploy to QA environment?')]
                            if (env.APPROVE_QA == 'YES')
				    {
			            stage('deploy to QA')
					    {
			         	    sh "docker run -p 8082:8080 bathinapullarao/spring-petclini:latest" 
                                           // dipQA(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8086)
                                            }
	                             env.DPROD = true
                            	    } 
				    else 
				    {
                                env.DPROD = false
			        echo "QA test Faild"
                                    }
                            }
                          } 
			catch (error) 
			  {
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to QA automatically activated'
                          }
                      }
	  }
	
	
	
/*      stages 
     {
        stage('parallel deploytoUAT prod')
 	{
            parallel
           {          */
		    stage('approvalOfUAT')
	     	   {
    		input "Deploy to UAT?"
     		   }
    		node
		   {
			slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script
			{
                    try
		           {
                        timeout(time:01, unit:'MINUTES')
			       {
                            env.APPROVE_UAT = input message: 'Deploy to UAT', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_UAT', choices: 'YES\nNO', description: 'Deploy to UAT?')]
                            if (env.APPROVE_UAT == 'YES')
				    {
				    stage('deploy to UAT')
					    {
					   sh "docker run -p 8083:8080 bathinapullarao/spring-petclini:latest" 
        			    	//dipUAT(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8087)
        				    }
                                env.DPROD = true
                            	    } 
				    else 
				    {
                                env.DPROD = false
			        echo "UAT faild"
                            	    }
                                }
                            }
								
		  catch (error) 
			 {
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to PRODUCTION automatically activated'
                    	 }
		      }
		}
          stage('approvalOfProd')
	     {
		input "Deploy to Prod?"
    	     }
    		node 
	     {
	    slackSend (channel: "#jenkins_notification", color: '#4286f4', message: "Deploy Approval: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.JOB_DISPLAY_URL})")
                script 
		{
                    try
		    {
                        timeout(time:10, unit:'MINUTES') 
			{
                            env.APPROVE_PROD = input message: 'Deploy to Production', ok: 'Continue',
                                parameters: [choice(name: 'APPROVE_PROD', choices: 'YES\nNO', description: 'Deploy from STAGING to PRODUCTION?')]
                            if (env.APPROVE_PROD == 'YES')
			    {
                                stage('deploy to Prod')
			        {
				         sh "docker run -p 8084:8080 bathinapullarao/spring-petclini:latest" 
        				//dipProd(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, 8088)
        		        }
					    env.DPROD = true
			    }
		            else
			    {
                                env.DPROD = false
				echo "Rejected to Deploy by DEVOPS eng"
                            }
                        }
                     }
		     catch (error) 
	             {
                        env.DPROD = true
                        echo 'Timeout has been reached! Deploy to PRODUCTION automatically activated'
                     }
		} 
	  }                      } 


// }  } }
