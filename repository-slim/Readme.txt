*************************************************************
*	The purpose of this project is just to generate 		
*	a version of pentaho-platform-repository dependency 	
*	that works with pentaho-server-slim attempt.			
*															
*	It copies the sources from the project					
*	pentaho-platform-repository								
*	and tries to apply changes in some classes		
*	through a script "slim-scripts".						
*															
*	The script uses an original (_ori) and 					
*	original_changed (_orichg) version of the classes		
*	it tries to change, located in:							
*	\src\main\changes\...									
*															
*	A 3-way merge is tried between the original, changed	
*	and current version (_new) of each class.				
*	In case the merge fails into a conflit, the build		
*	also fails, and the conflit has to be solved manually.	
*	The possible solution will be to manually update the	
*	original and original_changed class versions located	
*	located under \src\main\changes\... in order to be		
*	compatible with the new version of the class, keeping	
*	the necessary changes to work in pentaho slim.			
*															
*	WINDOWS NOTE:											
*	To work on windows, it has to run in a console that		
*	reconizes the "diff3" linux command (ex: cmder).	
*															
*************************************************************
