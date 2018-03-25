## This file contains all changes that were made to the codebase to change it to a corresponding 1.3 version.


##################################################################################################################
# The most obvious changes that occured is the file structure. It follows the Phoenix 1.3 file structure convention.
##################################################################################################################


##################################################################################################################
# The user.ex is located inside the "accounts" subdirectory. This is becuase version 1.3 now comes with the idea 
# of context. A context will group related functionalities. It often encapsulates patterns such as data access 
# and data validation. By using contexts, we decouple and isolate our systems into manageable, independent parts.
# The account.ex file contains all the functions that deal with actual database operations which include creating,
# reading, updating and deletion of data. The reason for this is that there will be separation of concerns. That 
# is, other modules such as the controllers do not need to know anything about access to data in the database.
##################################################################################################################


##################################################################################################################
# In the user.ex module, a list is used to contain atoms rather than the use of a sigil (~w()). Also in the 
# User.changeset/2 function, a validate_required/2 function was used to ensure that the @required_fields is present 
# in the changeset. Also, the second parameter of User.changeset/2 does not have a default parameter of :empty  
# unlike the corresponding Phoenix 1.2 version of the code. As a level of abstraction, in the accounts.ex, 
# the create_user/2 sets attrs to a default parameter of %{} which is later passed on to User.changeset/2. At this  
# point, attrs is either an empty map or a non-empty map.
#################################################################################################################


##################################################################################################################
# There also a few changes in registration_controller.ex. Since all of the data transactions that occur in the 
# database are now in account.ex, there is no need for the Registration module. Also the hashing of password could
# be done directly in the user module so it would just be piped in the changeset/2 function. In line 13 of 
# registration_controller, a call is being made to the create_user/2 function that is located in the context. As a 
# result of this, there is no more need for the Registration module.
###################################################################################################################


###################################################################################################################
# Also,the Session module located in session.ex is now located in the accounts subdirectory. One important thing to
# is that the a Accounts context can hold all the database transactions that have to do with the users. The Accounts
# context can also hold everything that has to do with the authentication of users since authentication of
# users is still directly scoped to users.
###################################################################################################################

##################################################################################################################
# A close look at the Session module indicates that no direct repo operation or database transaction was performed.
# In the 1.2 version, a Repo.get/2 operation was performed in the Session module. Since Phoenix 1.3 tries to
# separate concerns, all repo operations have now been moved into the Accounts context (account.ex). This is why
# functions get_user/1 and get_user_by_email/1 are now in the Accounts module. These functions were now then called
# in the Session module.
###################################################################################################################

##################################################################################################################
# One important correction that was made to the code was in the second line of the new.html.eex file. The
# full path is ../templates/session/new.html.eex. In the 1.2 tutorial code, the line is:
#
#                 <%= form_for @conn, session_path(@conn, :create), [name: :session], fn f -> %>   
#                                               
#                                       whereas it should be this:
# 
#                  <%= form_for @conn, session_path(@conn, :create), [as: :session], fn f -> %>
# 
# Notice that [name: :session] has changed to [as: :session]. Using the former causes an error but the latter works 
# fine.
################################################################################################################## 

