# 1. General Guidelines
collapsed:: true
    - ## 1.1. Good Naming
      collapsed:: true
        - Good naming is of paramount importance in ensuring the **comprehensibility** or **intelligibility** of the code. The key factor to evaluate is whether the name is "making the intention clear" or not. Below are some good examples and some bad examples of names.
        - Also, naming ties the mental model of the business into the code. Without proper naming, there will be a constant translation overhead between the mental model that the business has and what the code actually expresses.
        - ### Variable names
            - Bad Examples:
                - ```python
                  # the most frustrating kind of name
                  x = 25
                  
                  # still hard to understand. 
                  # Only exception to this rule is widely used abbreviations like pid, cid, user_acctid etc.
                  lv_pairs = {}
                  
                  # suffixing the type of the variable gives no additional information. 
                  # Similarly, also avoid names with '_data' or '_detail' suffix.  
                  campaign_dict = {}
                  
                  # vague boolean variable won't make the if statement read natural
                  if success:
                  ```
            - Good Examples:
                - ```python
                  # won't this read better when used in a statement or expression?
                  age = 25
                  
                  # in the age of auto-complete and wide screens, 
                  # long variable names don't have the disadvantages they once had
                  label_value_pairs = {}
                  
                  
                  # won't this read better when used in a statement or expression?
                  campaign = {}
                  
                  # think about how would the name sound like when used in an 'if' statement
                  if is_eligible_for_auto_optimize:
                  ```
        - ### Function/Method names
            - Function/Method names should have a present tense verb and optionally some noun
            - Bad Examples:
                - ```python
                  # no need to mention the "how" of an operation.
                  def get_search_engine_details_via_rest_api(): 
                  
                  # functions that return boolean value have the same naming rules as boolean
                  # variables. Think about how will it sound like when used in an 'if' statement
                  def check_is_eligble_for_optimization():
                  ```
            - Good Examples:
                - ```python
                  # even better, avoid the word "details". How about 'get_search_engine()' for example?  
                  def get_search_engine_details():
                  
                  # if is_eligible_for_auto_optimization() or if check_is_eligble_for_optimization(), 
                  # which one feels more natural to read? 
                  def is_eligible_for_auto_optimization():
                  ```
        - ### Class Names
            - Class names should usually be nouns.
            - Bad Examples
                - ```python
                  # (or Utils or Service) This is going to become a "dumping ground object" soon. 
                  # The name is vague, so any functionality related to Search Engine will be dumped here
                  class SearchEngineHelper:
                  
                  # If your base class has the word "Base" or "Abstract" in it, 
                  # then you haven't exercised your imagination enough.
                  class IdempotentCounter(IdempotentCounterBase):
                  
                  class AccountConfigs:  # no plurals. It doesn't read natural when used in a statement
                  ```
            - Good Examples
                - ```python
                  # it's long but descriptive. 
                  # And moreover, your IDE will help you with auto-complete
                  class SearchEngineRemoteConnectionCreator:
                  
                  # This is better. InstrumentationDevice is general. Counter is specific. 
                  # Instead of Counter, it could have been Gauge or Histogram and it would all feel natural
                  class IdempotentCounter(IdempotentInstrumentationDevice):
                  
                  class AccountConfig:  
                  ```
    - ## 1.2. Single Focus
      collapsed:: true
        - Any construct, be it a variable, a function/method, an object, a cluster of objects, a module or even a micro-service needs to have a singular well defined purpose. That's a basic pre-requisite to even begin to deal with complexity. Also, functions that lack a singular focus are also very hard to test reliably for their outcomes, because of the variety of the behaviour that is contained within them. Which makes writing comprehensive unit tests for them very hard. Which makes modifying them very risky.
        - ### Single Focus in Functions
            - Bad Examples
                - ```python
                  # This function is losing it's main focus by drowning 
                  # itself in the the nitty gritties of it's sub-steps. 
                  # instead of figuring out whether is_feature_enabled is true by itself, 
                  # why not delegate it to some other function?
                  # Similarly, instead of updating conversion_manager_links of user_accts of a user
                  # by itself, why not delegate it to some other function?
                  # Doing all this will make the intent of this function more visible and apparent
                  def verify_conversion_link_manager(userid, feature):
                      if userid and feature:
                          is_feature_enabled = FeatureManager().is_enabled(userid, feature)
                          if is_feature_enabled:
                              conversion_manager_links = db.query(
                                  "Some SELECT query upon user_accts_view")
                              for result in conversion_manager_links:
                                  if result['conversion_manager_error_msg'] is not None:
                                      db.query("UPDATE in user_accts table")
                  ```
            - Good Examples
                - ```python
                  # is the intention not clearer and more manifest now?
                  def verify_conversion_link_manager(userid, feature):  
                      if _is_feature_enabled(userid, feature):
                  		_update_user_accts_conversion_manager_links(userid)  
                  
                  # _ indicates that the function is 'internal'. See Encapsulation section
                  def _is_feature_enabled(userid, feature):  
                      if userid and feature:
                          return FeatureManager().is_enabled(userid, feature)
                      return False
                  
                  def _update_user_accts_conversion_manager_links(userid):
                  	conversion_manager_links = db.query("Some SELECT query upon user_acct_alerts_view")
                      for result in conversion_manager_links:
                          if result['conversion_manager_error_msg'] is not None:
                              db.query("UPDATE in user_accts table")
                  ```
        - ### Single Focus in Objects
            - An Object can also be lacking a single focus, even though all its methods have single foci themselves. It happens when the object is catering more than one concern within itself. This makes the object hard to write comprehensive unit-tests for.
            - Bad Examples
              collapsed:: true
                - ```python
                  # The below class is dealing with two concerns:
                  # 1. Stitching together different sub-components of an invoice
                  # 2. Calculating Discount amount while handling all it's intricacies
                  # Now if unit tests are to be written upon this class, then those
                  # will be clumsy. Because they will test for discount behavior indirectly.
                  # In real code, this sloppy practice will be much more perilous.
                  class InvoiceTotalCalculator:
                      def calculate_invoice_total(self, items: list[InventoryItem], coupon: Coupon, 
                  								country: Countries) -> float:
                          subtotal = self.__calculate_subtotal(items)
                  		discount_amount = self.__calculate_discount_amount(subtotal, coupon)
                          subtotal_after_discount = subtotal - discount_amount
                          return subtotal_after_discount
                  
                       def __calculate_subtotal(self, items: list[InventoryItem]) -> float:
                          subtotal = 0.0
                          for item in items:
                              subtotal += item.selling_price
                  
                          return subtotal
                  
                      def __calculate_discount_amount(self, subtotal: float, coupon: Coupon) -> float:
                          amount_to_deduct = self.__get_amount_to_deduct(subtotal, coupon.discount_value)
                  		amount_to_deduct = min(amount_to_deduct, coupon.max_discount, subtotal)
                  		return amount_to_deduct
                  
                  	def __get_amount_to_deduct(subtotal: float, coupon.discount_value: float) -> float:
                  		if coupon.discount_type == DiscountTypes.FLAT:
                              amount_to_deduct = coupon.discount_value
                          elif coupon.discount_type == DiscountTypes.PERCENTAGE:
                              amount_to_deduct = subtotal * discount_value / 100.0
                  		else:
                  			raise ValueError(f"Unrecognized DiscountType: {coupon.discount_type}")
                  		return amount_to_deduct
                  ```
            - Good Examples
              collapsed:: true
                - ```python
                  # Discount calculation is an important behavior in this context and now that it is in
                  # it's dedicated class, it's easier to write a `class TestDiscountCalculator` and
                  # cover all it's possible code execution paths, without causing the cognitive overload
                  class InvoiceTotalCalculator:
                  	_discount_calculator = DiscountCalculator()
                  
                       def calculate_invoice_total(self, items: list[InventoryItem], coupon: Coupon, 
                   								 country: Countries) -> float:
                          subtotal = self.__calculate_subtotal(items)
                  		discount_amount = self._discount_calculator.calculate_discount(subtotal, coupon)
                          subtotal_after_discount = subtotal - discount_amount
                          return subtotal_after_discount
                  
                       def __calculate_subtotal(self, items: list[InventoryItem]) -> float:
                          subtotal = 0.0
                          for item in items:
                              subtotal += item.selling_price
                  
                          return subtotal 
                  		
                  class DiscountCalculator:
                  	def calculate_discount(subtotal: float, coupon: Coupon) -> float:
                  		amount_to_deduct = self.__get_amount_to_deduct(subtotal, coupon.discount_value)
                  		amount_to_deduct = min(amount_to_deduct, coupon.max_discount, subtotal)
                  		return amount_to_deduct
                  
                  	def __get_amount_to_deduct(subtotal: float, coupon.discount_value: float) -> float:
                  		if coupon.discount_type == DiscountTypes.FLAT:
                              amount_to_deduct = coupon.discount_value
                          elif coupon.discount_type == DiscountTypes.PERCENTAGE:
                              amount_to_deduct = subtotal * discount_value / 100.0
                  		else:
                  			raise ValueError(f"Unrecognized DiscountType: {coupon.discount_type}")
                  		return amount_to_deduct
                  ```
            - Apart from this, another disadvantage of bundling more than one concern in a single construct (like function, object. etc) is that it makes logic reuse harder and leads to it's repetition in the codebase consequently. Which brings us to our next point.
    - ## 1.3. Avoiding Repetition of Logic
      collapsed:: true
        - Any piece of business logic (or even a purely technical but significant logic) shouldn't be repeated at more than one place in the codebase. Because whenever there's more than one copy of something, it always introduces an extra overhead of maintaining the consistency between the two copies upon the engineers. It also introduces testing overhead. Or worse, may lead to missing out of one of the copies. Below is an example
        - Bad Examples
          collapsed:: true
            - ```python
              # as it is apparent that the operations required to perform the authentication with
              # the search engine are repeated. And perhaps at many places in the codebase other
              # than these two places. So it is a good idea to pull that out such that it can be
              # reused at a lot of places.
              class campaign_execute:
              	def call_modify_campaigns():
              		account_svc_obj = get_entity_service_obj(ENTITY_CONSTS.ACCOUNT, self.db)
              		user_acct_info = account_svc_obj.get_entities(cid_list=[self.cid])
              		sef = search_engine_factory(self.db)
              		self.seobj = sef.get_seobj(cid=self.cid)
              		self.seobj.enable_daily_budget_status()
              		self.seobj.login(user_acct_info['userid'], user_acct_info['login'], 
              						 user_acct_info['password'], self.campaignid)
              		# rest of the method...
              
              
              class campaign_execute_yandex:
              	def call_modify_campaigns_yandex():
               		account_svc_obj = get_entity_service_obj(ENTITY_CONSTS.ACCOUNT, self.db)
              		user_acct_info = account_svc_obj.get_entities(cid_list=[self.cid])
              		sef = search_engine_factory(self.db)
              		self.seobj = sef.get_seobj(cid=self.cid)
              		self.seobj.enable_daily_budget_status()
              		self.seobj.login(user_acct_info['userid'], user_acct_info['login'], 
              						 user_acct_info['password'], self.campaignid)
              		# rest of the method...
              ```
        - Good Examples
          collapsed:: true
            - ```python
              # Another benefit is that in future if the mechanism of authentication changes,
              # then the change is required at only one place.
              class SearchEngineAccountAuthenticator:
              	def login_to_search_engine(db, cid):
              		account_svc_obj = get_entity_service_obj(ENTITY_CONSTS.ACCOUNT, db)
              		user_acct_info = account_svc_obj.get_entities(cid_list=[cid])
              		sef = search_engine_factory(db)
              		seobj = sef.get_seobj(cid=cid)
              		seobj.enable_daily_budget_status()
              		seobj.login(user_acct_info['userid'], user_acct_info['login'], 
              					user_acct_info['password'], user_acct_info['campaignid'])
              		return seobj
              		
              class campaign_execute:
              	_se_account_authenticator = SearchEngineAccountAuthenticator()
              
              	def call_modify_campaigns():
              		se_obj = self._se_account_authenticator.login_to_search_engine(self.cid)
              		# rest of the method
              
              class campaign_execute_yandex:
              	_se_account_authenticator = SearchEngineAccountAuthenticator()
              
              	def call_modify_campaigns_yandex():
              		se_obj = self._se_account_authenticator.login_to_search_engine(self.cid)
              		# rest of the method
              ```
        - ### Beware of D.R.Y Extremism
            - While it's good to have an eye for duplication, keep in mind that when we try to extract frivolous or peripheral operations into common functions without understanding them in their broader context, we risk introducing entanglement of two different concerns. Which may hurt us in longer term more than whatever little benefit it brings.
            - A bunch of statements may appear common at two places when observed without their context, but one needs to determine whether it is an **incidental commonality** or a **conceptual commonality**. The requirements of different contexts could evolve independently and that incidental commonality can be rendered obsolete in future.
            -
    - ## 1.4. Avoiding deep nesting
        - Deep nesting of `if-else` conditions can make a function **indecipherable** for anyone other than the person who wrote it. And when enough months or years pass, even the person who wrote that function forgets it's intent.
        - When the above mentioned principle of **Single Focus** is applied correctly upon functions, it automatically prevents this problem from occurring. Another benefit is that it removes the need of explaining the code with the help of comments.
        - Also check: https://youtu.be/CFRhGnuXG-4
    - ## 1.5. Avoiding Undeclared Constants
    - ## 1.6. Comments
        - If the code is complex enough that it requires comments to understand, then you should first look to simplify or refactor the code to make it intelligible, rather than relying on comments as a crutch. May be you can name the variables better. May be you can apply decomposition better.
        - Bad Examples
          collapsed:: true
            - ```python
              # if search engine is Yahoo JP
              if sid == 90:
              
              # checking whether the user has contact details or not
              if not (self.contactid or 'name' in self._rs or 'email' in self._rs):
              
              # sid is int
              def check_search_engine(sid):
              	pass
              ```
        - Good Examples
          collapsed:: true
            - ```python
              # comment no longer required, because we made it clear what 90 signifies
              if sid == YAHOO_JP_ID:
              
              # bundling the condition in a function removed the need for comment
              if not has_contact_details(self.contactid, self._rs):
              
              # what's the need of indicating the parameter type when there's type hints
              def check_search_engine(sid: int) -> bool:  # python3 syntax
              	pass
              ```
        - Use comments to explain the choices or trade-offs made while selecting a solution out of many. Because the choices that were rejected, won't be there in the code to explain themselves. Or may be tips for expert usage of an object or a function can be added as a comment. In short, use comments to explain what can't be figured out from the code already.
            - Example
              collapsed:: true
                - ```python
                  def get_pids_to_work_on(userid):  # type: (int) -> Iterable[TypedDict('_', {'pid': int, 'user_acctid': int})]
                      """
                          uploaded_file_conversion_path looks like this:
                          /data/objective_function_revenue/20230814/objective_function_revenue_17496_1700000002_1700000252_202308142232
                  
                          The part after the last '/' is in this format:
                              objective_function_revenue_{userid}_{user_acctid}_{pid}_{timestamp}
                  
                          Information like pid, and userid is extracted from those rows where this value starts with:
                              /data/objective_function_revenue
                      """
                      db = cv.db.DatabaseConnectionSingletonWrapper.get_user_timezone_aware_connection(userid)
                      date_filter = get_date_filter('3_days_ago', column_name='upload_offline_conversion.ctime', date_typecast=True)
                      query = """
                          SELECT 
                              (split_part(split_part(uploaded_file_conversion_path, '/', 5), '_', 6))::int as pid,
                              user_acctid
                          FROM
                              upload_offline_conversion 
                              INNER JOIN user_accts using(user_acctid)
                              INNER JOIN users ON users.userid = user_accts.acct_owner_userid
                          WHERE 
                              conversion_entity = 'Offline Conversion Feed'
                              AND split_part(uploaded_file_conversion_path, '/', 3) = 'objective_function_revenue'
                              AND users.userid = %(userid)s
                              AND %(date_filter)s
                      """ % {'userid': userid, 'date_filter': date_filter}
                      result = db.query(query).dictresult()
                      return result
                  ```
- # 2. Function Guidelines
    - ## 2.1. The interface of a function
        - Interface means the outer boundary of a complex thing through which that thing is interacted with. Or in short the "interaction surface". And the interface of something the first thing one examines to make sense of that thing. Now a function's interface is formed by:
            - it's name
            - it's parameters and their types
            - it's return type
        - Without getting these right, a function won't make sense to anyone other than it's author. So pay attention to these factors before even starting to write a function.
        - Bad Examples
            - ```python
              # how is one supposed to know what is acceptable in __init__()
              # and what is not?
              class ParallelTrackingMigration:
              	def __init__(self, **params)
              		self.user_acctid = params['user_acctid']
              		self.userid = params['userid']
              		self.campaignid = params['campaignid']
              		# ... more such assignments
              
              # type of the input parameters and the expected return type
              # is not clear
              def create_classclicks_row(self, click, class_rows, timezone):
                  class_clicks = None
                      
                  s_kwcid = click[1]
                  class_row = self.get_class_row(s_kwcid, class_rows)
                  if None != class_row:
                      class_clicks = []
                      class_clicks.append(s_kwcid)
                      class_clicks.append(class_row[1])
                      class_clicks.append(class_row[2])
                      class_clicks.append(class_row[3])
              		# ... a lot of such append statements
              	return class_clicks
              ```
        - Good Examples
            - ```python
              # both the below alternatives are better than simply **params because they
              # make explicit what is expected as an input and what is not
              class ParallelTrackingMigration:
              	#alternative 1
              	def __init__(self, user_acctid: int, userid: int, campaignid: str, .....) -> None:
              		self.user_acctid = user_acctid
              		self.userid = userid
              		# other such assignments
              
              	# alternative 2, use a Data transfer object
              	def __init__(self, user_acct_row: UserAccountRow) -> None:
              		# assume there's a class UserAccountRow with the required fields
              		self.user_acctid = user_acct_row.user_acctid
              		self.userid = user_acct_row.userid
              		# ... more such assignments
              
              
              
              # The name, the parameter types and the return type together make a significant
              # difference in the comprehensibility of the function. 
              def create_classclicks_row(self, click: ClickData, class_rows: list[list[int, int, str]], 
              						   timezone: str) -> List[Union[str, int]]:
              	# ... the rest of the function body
              	return class_clicks
              ```
    - ## 2.2. Type Hints
        - Type Hints for parameters and return value of a function/method are important. They, along with the name of the function/method, provide the information necessary to understand it. They can also help prevent bugs from going to production if your IDE is configured to warn you upon type mismatch. Please read [this article](https://fastapi.tiangolo.com/python-types/) by FastAPI's author to understand their need further. For more guidance on how to add type hints, read this: [https://peps.python.org/pep-0484/#suggested-syntax-for-python-2-7-and-straddling-code](https://peps.python.org/pep-0484/#suggested-syntax-for-python-2-7-and-straddling-code)
        - Another benefit of type hints is that it opens up the possibility to use a tool like [mypy](https://github.com/python/mypy) to introduce further safety and consequently catch more bugs at development stage.
        - Example (in Python3.9 and Up)
            - ```python
              from typing import Union  # in python 3.10 onwards, even Union is not required, instead of param: Union[str, int] one can simply write param: str | int
              
              class Person:
              	name: str
              	age: int
              
              def some_function(param1: int, param2: str, param3: dict[float, bool], param4: Person, param5: set[tuple[str]], param6: Union[list[int], None]) -> list[str]:
              	pass
              
              ```
        - ### Special Mention: Dicts vs TypedDicts vs Dataclasses
            - The Disadvantage of using `dict`  parameter in functions and methods is that what keys and what kind of values are acceptable, is not clearly evident. it needs to be figured out from the function body. That is why it is better to use an `Object`  to bundle related data, rather than `dict`
            - Bad Example
                - ```python
                  # To utilize this function, one has to go through it's body 
                  # to figure out what should the `ads` argument contain, 
                  # in order for this function to run properly.
                  # That's why, for any new function, try not to use dict as
                  # it's parameter type or return type. Rather use an object
                  # which takes out the guesswork from the expected data format.
                  # 
                  # Another disadvantage is that your IDE won't be able to warn
                  # you of any potential KeyError that has creeped in due to
                  # you mis-spelling a key's name.
                  #
                  # This problem doesn't occur with objects as the IDE itself
                  # suggests available field names and warns upon trying to
                  # access a non-existing field
                  
                  def modify_ads(self, ads: list[dict[str, Any]):
                      for ad in ads:
                          if not ad.get('termid') or not ad.get('adref'):
                              self.error('Entry missing termid or adref.')
                              continue
                          adref = ad['adref']
                  		# rest of the function...
                  ```
            - Good Example
                - ```python
                  from dataclasses import dataclass
                  @dataclass(frozen=True)  # removes the need of declaring the constructor
                  class Ad:
                  	termid: int
                  	adref: str
                  
                  """ on python2
                  class Ad:
                  	termid = None # type: int
                   	adref = None # type: str
                  
                  	def __init__(self, termid, adref):  # type (int, str) -> None
                  		self.termid = termid  # keep the fields public as this
                  		self.adref = adref  # object is just to bundle data
                  """
                  # now it's clearer what fields to expect in Ad
                  def modify_ads(self, ads: list[Ad]):
                  	for ad in ads:
                  		if not ad.termid or not ad.adref:
                          	self.error('Entry missing termid or adref.') 
                  			continue
                  		adref = ad.adref # rest of the function...
                  ```
            - But sometimes, a function is already written and it's hard to refactor it without risking disruption. Or may be the library you depend on, doesn't have type hints. In that case, make use of `TypedDict`  to introduce a hint about the expected fields in the `dict`  parameter or return value more explicit.
    - ## 2.3. Requesting only the required information
        - Not following this hurts the reusability, limits the applicability and muddies the intent of a function.
        - Bad Example
            - ```python
              # assume User class has these fields: name, date_of_birth, email, phone_number
              # This Function can only be utilized where a User object exists.
              # Which may force someone to write a new function, which duplicates
              # the functionality, but accepts just a string as an argument.
              def validate_email(user: User) -> bool:  
                  email = user.email  # only this data is useful to this function
                  # logic to validate the email
              ```
        - Good Example
            - ```python
              # This function can be used even at places where a User
              # object is not available. This prevents the need for
              # writing duplicate function. This is a trivial example
              # but repetition of important logic (business or otherwise)
              # can make a codebase more risky to work on.
              def validate_email(email: str) -> bool:
              	# logic to validate the email
              ```
- # 3. Object Oriented Programming Guidelines
    - ## 3.1. What are objects?
      collapsed:: true
        - In essence there are **two** kinds of objects. **Data centric objects** and **Behaviour centric objects**. There are two important kinds of data centric objects, **Entities** and **Value objects**. Behaviour centric objects are also called **Service objects**. We'll see each kind in some detail
        - ### Entities
            - Entities are those objects who have an identity that is not changed by the changes of it's attributes. It also represents a long lived information which is relevant in the business context. Usually entities are persisted in the database for future retrieval. In our business domain, we have Campaigns, User Accounts, Ad Groups, Keywords etc. as entities for example. It is recommended to use an ORM for representing entities and abstracting away the Database queries and easily mocking the database interaction in the tests. The name of the entity must be compliant with the guidelines for class names
            - Example:
              collapsed:: true
                - ```python
                  class UserCampaign(db.Model):
                      __tablename__ = 'user_campaigns'
                      cid = db.Column(db.Integer, primary_key=True)
                      campaignid = db.Column(db.String)
                      budget = db.Column(db.Integer)
                      user_acctid = db.Column(Integer, ForeignKey('user_accts.user_acctid'))
                      ...
                  	@property
                  	def budget_value(self):
                          if self.type == 'something':
                              return self.budget
                          else:
                              return self.target_cpa
                  ```
            - Entity objects should have simple methods that do simple operations, that usually operate upon it's own data. Ideally, without requiring any other entity as an input. Heavy duty business logic should be off-loaded to Service objects.
        - ### Value objects
            - The key difference between value objects and entities is that value objects lack a persisting identity. For example, two Money objects representing 5$ are equal to each other, but two Orders (in an e-commerce domain) with exactly the same items are still two different orders. Value objects are many a times an attribute of an another larger data centric object.
            - Examples
                - ```python
                  class UserAccountConfig:
                      tracking_type: str
                      redirect_type: str
                      append_parameter: bool
                  
                  user_acct.acct_config = UserAccountConfig(...)
                  ```
            - Also, the attributes of value objects ideally don't change. In Python3, Value objects can be represented using `dataclasses` or using `PyDantic`  library.
            - #### Data Transfer objects
                - Data Transfer objects (DTO's) are those objects whose sole purpose is to bundle the pieces of data in one container and pass it around. Be it within an application, in the form of function parameter or return value, or between two applications via HTTP or some other mechanism. It's a common mistake to use `dict` to bundle the data together, but it has shortcomings that are discussed in the Dicts vs TypedDicts vs DataClasses, but in brief, the expected fields are not explicit.
                - Example
                  collapsed:: true
                    - ```python
                      from dataclasses import dataclass
                      
                      # in python3
                      @dataclass(frozen=True)
                      class Failure:
                      	entity_id: Union[int, str]
                      	entity_field: str
                      	generated_by: str
                      	failure_reason: str
                      
                      """
                      # in python2
                      class FailureInformation(object):
                          def __init__(self, entity_id, entity_field, generated_by, failure_reason):
                              # type: (int or str, str, str, str) -> None
                              self.entity_id = entity_id
                              self.entity_field = entity_field
                              self.generated_by = generated_by  # the class that created this failure information object
                              self.failure_reason = failure_reason
                      """
                      
                      @six.add_metaclass(abc.ABCMeta)
                      class FailedEntityIdsFinder:
                          ERROR_LOG_TEXT = ""  # type: str
                          _logger = None  # type: dummy_logger
                      
                      	# imagine this method's return type as List[Dict], would that be informative to someone who's providing an implementation for this method?
                          @abc.abstractmethod
                          def get_failures(self, userid):
                              # type: (int) -> List[FailureInformation]
                              pass
                      ```
        - ### Service Objects
            - Service objects represent actions, operations or processes of the business. They may even depend on other service objects to carry out their responsibility.
            - Example:
              collapsed:: true
                - ```python
                  class AdExecuteValidationProcessRunner(object):
                      _logger = getLogger(name="VALIDATOR.AD_EXECUTE", enable_db_tag_prefix=True)  # type: dummy_logger
                      _discrepancies_counter = ad_execute_discrepancies_counter  # type: prometheus_client.Counter
                      _failed_entity_ids_finders = [FailedAdInstanceIdsFinder()]  # type: List[FailedEntityIdsFinder]  # depends on a list of FailedEntityIdsFinder objects
                      _entity_details_fetcher_function_for_logs = get_adinstance_details_for_logs  # type: Callable[[List[int]], cv.db.DictResult]
                      NO_ERROR_LOG_TEXT = "No bid push failures detected"  # type: str
                  
                      def __init__(self):
                          self._db_tag = os.environ['DB_TAG']
                          self._db = cv.db.DatabaseConnectionWrapper.get_connection()
                  
                      def run(self, input_entity_ids=None):
                          # type: (List[int]) -> bool
                          process_success = True
                          error_logs_printed = False
                  
                          for failed_ids_finder in self._failed_entity_ids_finders:
                              failed_entity_ids = failed_ids_finder.get_failed_ids(input_entity_ids)
                              if len(failed_entity_ids) > 0:
                                  self.__print_logs_for_debugging(failed_entity_ids, failed_ids_finder.ERROR_LOG_TEXT)
                                  self.__increment_discrepancies_counter_by(len(failed_entity_ids))
                                  error_logs_printed = True
                  
                          if not error_logs_printed:
                              self._logger.info(self.NO_ERROR_LOG_TEXT)
                  
                          return process_success
                  
                  
                  class FailedAdInstanceIdsFinder(FailedEntityIdsFinder):
                      ERROR_LOG_TEXT = "Bid push had failed for"
                      _logger = getLogger(name="VALIDATOR.AD_EXECUTE.FAILED_IDS_FINDER", enable_db_tag_prefix=True)
                  
                      def get_failed_ids(self, input_adinstids):
                          # type: (List[int]) -> List[int]
                          # ... details left out for brevity
                          return failed_adinstids
                  ```
            - Service objects are the "doer" objects and naturally, should have names which end with "er" or "or", like UserAccountCreator or CampaignBudgetPusher for example. The only exception to this rule are objects which follow some convention and end with, for example, "-Repository" or "-WebClient" or "-Factory" etc.
    - ## 3.2. Why are objects even needed?
      collapsed:: true
        - To understand this, you'll have to understand the side effect of application of **Decomposition** Principle. Suppose you have this large function consisting of three logical sub-operations that you break down into  three smaller functions
            - Large Unmanageable Function
                - ```python
                  def important_operation(some_params):
                  	# lots of code to perform sub-operation 1
                  	# still more lines to perform sub-operation 2
                  	# yet more lines to perform sub-operation 3
                  ```
            - After Application of Decomposition Priciple
              collapsed:: true
                - ```python
                  def important_operation(some_params):
                  	perform_sub_operation_1()
                  	perform_sub_operation_2()
                  	perform_sub_operation_3()
                  
                  def perform_sub_operation_1():
                  	# code to perform sub-operation 1
                  
                  def perform_sub_operation_2():
                  	# code to perform sub-operation 2
                  
                  def perform_sub_operation_3():
                  	# code to perform sub-operation 3
                  
                  ```
        - Problem solved, right? Wrong! The point is, that the functions `perform_sub_operation_X()` were all written to support the `important_operation()`  function. And although the unintelligibility problem has been solved, three problems that have been created:
            - The functions `perform_sub_operation_X()`  were created to **support** the main function `important_operation()`  and are it's **internal details**. But they have now been exposed out, side by side with other main functions. In a large codebase, this practice will lead to a sea of functions, and will make it hard to even figure out where to start reading the code from.
            - Since those sub-operation functions were **internal details**, they are subject to change whenever the requirements of the entry-point function change. But keeping these sub-operations out and easily accessible invites their re-use at other places. This is detrimental as it causes entanglements (or coupling) to develop where they shouldn't have. And they pave the way for the eventual **code sphagettification**. This is something also alluded to, in "Avoid DRY extremism".
        - This is why there's a need to provide functionality in a restricted and controlled manner. And this is exactly what the concept of **Encapsulation** is about. Consider this:
            - After enclosing the important operation in an object
                - ```python
                  class YourBusinessLogicPerformer:
                  	def important_operation(self, some_params):
                  		self.__perform_sub_operation_1()
                  		self.__perform_sub_operation_2()
                  		self.__perform_sub_operation_3()
                  
                  	def __perform_sub_operation_1(self):
                  		# code to perform sub-operation 1
                  
                  	def __perform_sub_operation_2(self):
                  		# code to perform sub-operation 2
                  
                  	def __perform_sub_operation_3(self):
                  		# code to perform sub-operation 3
                  ```
        - The benefit of packaging all these functions inside a class with only one of them accessible from outside the class solves both the problems to a great extent. It demarcates an area of concern well within the class and because only the entry-point function is publicly accessible, it aids the reader by hinting about where to start reading this piece of code from. Moreover, it also prevents direct dependency from forming upon the sub-operations. A useful analogy to think of is of a TV remote control. It's internal electronic nitty-gritties are packaged in a casing rather than being directly exposed. But there is a controlled way to interact with those electronic circuits through the medium of the buttons available on the device.
    - ## 3.3. Constructors
        - Constructors exist to instantiate an object in a valid state, with all the information it needs to carry out it's responsibilities.
        - ### Service Objects
            - Service objects are "doer" objects, and they exist to encapsulate a functionality within them, not data. So their constructors should not take such data inputs, which would require them to be instantiated every time, their use is needed.
            - Bad Example:
              collapsed:: true
                - ```python
                  # The below class will require to be instantiated 
                  # for every cid, search_engine combination. 
                  # This is not something to be provided to a constructor.
                  # You should be able to instantiate 
                  # AdExecute class once and re-use the 
                  # same object throughout your process/application.
                  
                  class AdExecute:
                  	def __init__(self, db, cid, search_engine):
                  		self.db = db
                  		self.cid = cid
                  		self.search_engine = search_engine
                  
                  	def run():
                  		logger.info("working on {self.cid}")
                  		# rest of the method
                  ```
            - Good Example:
              collapsed:: true
                - ```python
                  # Database connection object is a "dependency" whose functionality is
                  # required for AdExecute to carry out it's job. That's why it's supplied
                  # right at the instantiation, so that the AdExecute object needs no
                  # further build-up after it's object is created.
                  # By making cid and search_engine the parameters of the public method
                  # you get two advantages. 
                  # 1) Same AdExecute object can be re-used for different cids and search_engines. 
                  # 2) The data required by AdExecute to carry out it's responsibility is evident. 
                  # (Read "The interface of a function" section for further explanation)
                  class AdExecute:
                  	def __init__(self, db):
                  		self.db = db
                  
                  	def run(cid, search_engine):
                  		logger.info("working on {cid}")
                  		# rest of the method
                  ```
    - ## 3.4. Public, Private, Protected
        - Only the **front-facing**, "entry-point" methods should be **public**. The methods written to **support** those front-facing methods should be kept **private**.
        - Bad Example
            - ```python
              class AccountUploadConversionTracker(object):
              	def upload_account_level_conversion_tracker(self):
              	 	self.create_account_conversion_temp_table()
                      self.load_temp_table_with_latest_account_conversion_file()
                      self.upload_conversion_tracker_to_search_engine()
              
              	def create_account_conversion_temp_table(self):
              		# method body
              	
              	def load_temp_table_with_latest_account_conversion_file(self):
              		# method body
              
              	def upload_conversion_tracker_to_search_engine(self):
              		# method body
              ```
        - Good Example
            - ```python
              class AccountUploadConversionTracker(object):
              	def upload_account_level_conversion_tracker(self):
              	 	self.__create_account_conversion_temp_table()
                      self.__load_temp_table_with_latest_account_conversion_file()
                      self.__upload_conversion_tracker_to_search_engine()
              
              	def __create_account_conversion_temp_table(self):
              		# method body
              	
              	def __load_temp_table_with_latest_account_conversion_file(self):
              		# method body
              
              	def __upload_conversion_tracker_to_search_engine(self):
              		# method body
              ```
        - Protected methods are only to be used when an internal method of a class needs to be overriden by the subclass
            - Example
                - ```python
                  @six.add_metaclass(abc.ABCMeta)
                  class UploadConversionTracker(object):
                  	def upload_account_level_conversion_tracker(self):
                  	 	self.__create_account_conversion_temp_table()
                          self._load_temp_table_with_latest_account_conversion_file()
                          self.__upload_conversion_tracker_to_search_engine()
                  
                  	def __create_account_conversion_temp_table(self):
                  		# method body
                  
                  	@abc.abstractmethod
                  	def _load_temp_table_with_conversion_file(self): 
                  		# this method is protected. Notice the _ in the name
                  		# Only if there's a variation in how to load the temp table,
                  		# which different sub-classes are going to specify
                  		pass
                  
                  	def __upload_conversion_tracker_to_search_engine(self):
                  		# method body
                  ```
    - ## 3.5. Inheritance
        - If you think inheritance is for "code reuse", please change your opinion about it. Utilizing inheritance with that objective creates such tightly coupled and brittle code that is hard to adapt to changes in the requirements. Never use inheritance in isolation to other principles of OOP, like Abstraction and polymorphism. Remember, inheritance is to represent a "family of similar objects", not to "re-use code".
            - Bad Example
              collapsed:: true
                - ```python
                  # This arrangement gives the impression that CPC Campaigns are a type of Smart Campaigns,
                  # Which is wrong. This is not how functionality is supposed to be shared.
                  class FailedSmartCidsFinder(FailedEntityIdsFinder):
                      def get_failures(self, userid):
                          # type: (int) -> List[Failure]
                          cid_to_expected_budgets = self.__get_cid_to_expected_budget_mapping(userid)
                  
                          cids_with_actual_budgets = self.__get_cids_with_actual_budgets(
                              userid, cid_to_expected_budgets.keys())
                  
                          failed_cids = self._get_failed_cids(cids_with_actual_budgets, cid_to_expected_budgets)
                  
                          return failed_cids
                  
                  	def _get_failed_cids(cids_with_actual_budgets, cid_to_expected_budget_mapping):
                  		# type: (Iterable[Dict[str, int or float]], Dict[int, TypedDict('_', dbc)]) -> List[Failure]
                  		for cid_and_budget in cids_with_actual_budgets:
                              cid, budget = cid_and_budget[self.ID_FIELD], cid_and_budget[self.COMPARISON_FIELD]
                              if not self._update_succeeded_for(budget, cid_to_expected_budget_mapping[cid]):
                                  failed_cids.append(FailureInformation(
                                      cid, self.ID_FIELD, self._class_name, 'because actual does not match expected'
                                  ))
                          return failed_cids
                  
                  
                  class FailedCpcCidsFinder(FailedSmartCidsFinder):
                      def _get_failed_cids(self, cids_with_actual_budgets, cid_to_expected_budget_mapping):
                          # type: (Iterable[Dict[str, int or float]], Dict[int, TypedDict('_', dbc)]) -> List[Failure]
                          for cid_and_budget in cids_with_actual_budgets:
                              cid, actual_budget = cid_and_budget[self.ID_FIELD], cid_and_budget['daily_budget']
                              row = cid_to_expected_budget_mapping[cid]
                              if not self._update_succeeded_for(actual_budget=actual_budget,
                                                                expected_budget=row['daily_budget'],
                                                                currency_min_bid=row['cur_min_bid'],
                                                                currency_min_increment=row['cur_min_incr'],
                                                                search_engine=row['search_engine']
                                                                ):
                                  failed_cids.append(FailureInformation(
                                      cid, self.ID_FIELD, self._class_name, 'because actual does not match expected'
                                  ))
                          return failed_cids 
                  ```
            - Good Example
              collapsed:: true
                - ```python
                  @six.add_metaclass(abc.ABCMeta)
                  class FailedCidsFinder(FailedEntityIdsFinder):
                  	def get_failures(self, userid):
                          # type: (int) -> List[Failure]
                          cid_to_expected_budgets = self.__get_cid_to_expected_budget_mapping(userid)
                  
                          cids_with_actual_budgets = self.__get_cids_with_actual_budgets(
                              userid, cid_to_expected_budgets.keys())
                  
                          failed_cids = self._get_failed_cids(cids_with_actual_budgets, cid_to_expected_budgets)
                  
                          return failed_cids
                  
                  	@abc.abstractmethod
                  	def _get_failed_cids(cids_with_actual_budgets, cid_to_expected_budget_mapping):
                   		# type: (Iterable[Dict[str, int or float]], Dict[int, TypedDict('_', dbc)]) -> List[Failure] 
                  		# note that this method is protected
                  		pass
                  
                  
                  class FailedSmartCidsFinder(FailedCidsFinder):
                      
                  	def _get_failed_cids(cids_with_actual_budgets, cid_to_expected_budget_mapping):
                  		# type: (Iterable[Dict[str, int or float]], Dict[int, TypedDict('_', dbc)]) -> List[Failure]
                  		for cid_and_budget in cids_with_actual_budgets:
                              cid, budget = cid_and_budget[self.ID_FIELD], cid_and_budget[self.COMPARISON_FIELD]
                              if not self._update_succeeded_for(budget, cid_to_expected_budget_mapping[cid]):
                                  failed_cids.append(FailureInformation(
                                      cid, self.ID_FIELD, self._class_name, 'because actual does not match expected'
                                  ))
                          return failed_cids
                  
                  
                  class FailedDailyBudgetCidsFinder(FailedCidsFinder):
                      def _get_failed_cids(self, cids_with_actual_budgets, cid_to_expected_budget_mapping):
                          # type: (Iterable[Dict[str, int or float]], Dict[int, TypedDict('_', dbc)]) -> List[Failure]
                          for cid_and_budget in cids_with_actual_budgets:
                              cid, actual_budget = cid_and_budget[self.ID_FIELD], cid_and_budget['daily_budget']
                              row = cid_to_expected_budget_mapping[cid]
                              if not self._update_succeeded_for(actual_budget=actual_budget,
                                                                expected_budget=row['daily_budget'],
                                                                currency_min_bid=row['cur_min_bid'],
                                                                currency_min_increment=row['cur_min_incr'],
                                                                search_engine=row['search_engine']
                                                                ):
                                  failed_cids.append(FailureInformation(
                                      cid, self.ID_FIELD, self._class_name, 'because actual does not match expected'
                                  ))
                          return failed_cids 
                  ```
            - Protected methods are only to be used when an internal method of a class needs to be overriden by the subclass.
            - Read about Template Method Design Pattern to understand the proper way to use inheritance.
            - ### When to use an abstract base class vs. an interface(protocol)
                - In short, use ABC to enforce a structure and use interface (protocol) to enforce a contract.
    - ## 3.6.  Type hints for instance and class variables
        - Type hints are important for class and object variables too, just like in the case of function/method parameters and return values.
        - Example:
          collapsed:: true
            - ```python
              # in python 3
              class SomeClass:
              	SOME_CONSTANT: int = 10000 
              
              	def __init__(self, some_value: str) -> None:
              		self.__some_value: float = some_value
              
              
              # in python 2
              class SomeClass:
              	SOME_CONSTANT = 10000  # type: int
              
              	def __init__(self, some_value):
              		# type (int) -> None
              		self.__some_value = some_value # type: str
              ```
    - ## 3.7.  Dependency Injection
- # 4.   Unit Testing Guidelines
    - Unit tests are of critical importance to have a safe development process where a lot of bugs are caught before they make it to production. Tests are not just a good to have. They are as essential to your application code, as a scaffolding is to a building under construction. No construction worker thinks, why are we wasting time building this structure which nobody will live in. Well that's because that supposedly "secondary" structure enables you to build your primary structure with efficiency and safety.
    - Writing tests costs extra time only when they are written from scratch the first time. But in the overall lifetime of a software, they require only minimal changes, as the software adapts to changing requirements. And they actually save time by reducing the manual testing effort.
    - Without Tests, you may gain speed at an individual level in short term, but as a team we all will slow down in long term.
    - ## 4.1.  Characteristics of a good unit test:
        - Mocks the dependencies of the unit being tested. Be it other functions/objects or database and network interactions.
        - Accurately conveys what are the expectations from the unit that it is testing. In case of tests, the mantra is "Make the expectations clear"
        - **Tests** the **output** of the unit as well as the **interactions** of the unit with the other units. View this Recording for better understanding:
    - ## 4.2.   Coverage
        - Unit tests should cover every potential execution path that the unit (be it a function or a class) may have, due to conditional statements.
        - Example function
            - ```python
              # For the sake of brevity, small examples
              # are used as an illustration. Usually you 
              # will write one test case class for a
              # function that may be broken down into
              # smaller functions or for an object
              # which has one or two public methods and
              # several private methods
              def get_greeting(time_of_day, username):
              	greeting = ''
              	if time_of_day == 'Morning':
              		greeting = 'Good Morning'
              	else:
              		greeting = 'Welcome'
              	return '{} {}'.format(greeting, username) 
              ```
        - Inadequate Tests
            - ```python
              import unittest
              from whatever.file import get_greeting
              
              
              # Doesn't cover and guard the case where time_of_day is
              # 'Morning'.
              # If someone in future inadvertently changes the behaviour
              # of this case by introducing a typo, then the unit tests
              # will not be able to warn us of this incorrect change
              
              class TestGetGreeting(unittest.TestCase):
              	def test_get_greeting(self):
              		greeting = get_greeting('Afternoon', 'Clark')
              		self.assertEqual(greeting, 'Welcome Clark')
              ```
        - Good Tests
            - ```python
              import unittest
              from whatever.file import get_greeting  
              
              # if it is important to the business that the user be
              # greeted with 'Good Morning {username}' if the time of the
              # day is morning, then that should reflect in the tests too. 
              class TestGetGreeting(unittest.TestCase):
              	def test_get_greeting_non_morning_time(self):
              		greeting = get_greeting('Afternoon', 'Clark')
              		self.assertEqual(greeting, 'Welcome Clark')
              
              	def test_get_greeting_morning_time(self):
              		greeting = get_greeting('Morning', 'Lois')
              		self.assertEqual(greeting, 'Good Morning Lois')
              ```
    - ## 4.3.   Mocking
        - In Unit testing, mocking is important to test an object's or a function's behavior in isolation, and to keep the unit-test intelligible
        - Sample Class
          collapsed:: true
            - ```python
              # Asssume you have AdExecuteValidationProcessRunner which depends on FailedAdInstanceIdsFinder. And you want to write unit tests for AdExecuteValidationProcessRunner
              class AdExecuteValidationProcessRunner(object):
                  _logger = getLogger(name="VALIDATOR.AD_EXECUTE", enable_db_tag_prefix=True)  # type: dummy_logger
                  _failed_entity_ids_finders = [FailedAdInstanceIdsFinder()]  # type: List[FailedEntityIdsFinder]
              
                  def __init__(self, userid):
                      # type: (int) -> None
                      self._db_tag = os.environ['DB_TAG']
                      self._userid = userid
              
                  def run(self):
                      # type: () -> bool
                      process_success = True
                      error_logs_printed = False
              
                      try:
                          for failed_ids_finder in self._failed_entity_ids_finders:
                              failed_entity_ids = failed_ids_finder.get_failures(self._userid)
                              self.__print_logs_for_debugging(failed_entity_ids)
              
                      except Exception:
                          self._logger.error("Failed to run properly - {}".format(traceback.format_exc()))
                          process_success = False
              
                      return process_success
              
                  def __print_logs_for_debugging(self, failures):
                      # type: (List[FailureInformation]) -> None
                      for failure in failures:
                          self._logger.error(str(failure))
              
              
              class FailedAdInstanceIdsFinder(FailedEntityIdsFinder):
                  AD_EXECUTE_ERROR_LOG_TEXT = "Bid push had failed"
                  AD_STATUS_ERROR_LOG_TEXT = "Ad Status sync back had failed"
                  _logger = getLogger(name="VALIDATOR.AD_EXECUTE.FAILED_IDS_FINDER", enable_db_tag_prefix=True)
              
                  def get_failures(self, userid):  # type: (int) -> List[FailureInformation]
                      ad_execute_rows = get_adinstids_and_expected_bids_from_ad_execute(userid)
              
                      failures = []
              
                      for ad_execute_row in ad_execute_rows:
                          adinstid, algo_suggested_bid, adinstance_status_output, ad_actions_latest_output = (
                              ad_execute_row['adinstid'], ad_execute_row['input_bid'],
                              ad_execute_row['ast_output_bid'], ad_execute_row['aal_output_bid'])
              
                          increment, search_engine = ad_execute_row['cur_increment'], ad_execute_row['search_engine']
                          expected_bid = self.__get_bid_after_round_off(algo_suggested_bid, increment)
              
                          failure = self.__get_failure(adinstid, expected_bid, adinstance_status_output, ad_actions_latest_output)
                          if failure:
                              failure.set_contextualizing_variables(dict(
                                  userid=userid, search_engine=search_engine, user_tier=ad_execute_row['user_tier'],
                                  cid=ad_execute_row['cid'], adid=ad_execute_row['adid'], user_acctid=ad_execute_row['user_acctid'],
                                  match_type=ad_execute_row['match_type'], currency_increment=increment
                              ))
                              failures.append(failure)
              
                      return failures
              ```
        - Bad Example
          collapsed:: true
            - ```python
              @mock.patch.object(AdExecuteValidationProcessRunner, '_logger')
              class TestAdExecuteValidator(unittest.TestCase):
                  adinstances = [
                      {'adinstid': 1, 'cid': 100, 'user_acctid': 180, 'userid': 175,
                       'search_engine': 'Google Adwords', 'user_tier': 'Tier1'},
                      {'adinstid': 2, 'cid': 102, 'user_acctid': 181, 'userid': 175,
                       'search_engine': 'MSN adCenter', 'user_tier': 'Tier1'},
                      {'adinstid': 3, 'cid': 104, 'user_acctid': 182, 'userid': 175,
                       'search_engine': 'Google Adwords', 'user_tier': 'Tier1'}
                  ]
                  failed_adinstance = adinstances[0]
                  failures = [FailureInformation(
                      failed_adinstance['adinstid'], 'adinstid', 'FailedAdInstanceIdsFinder',
                      'Bid push had failed because actual: 125 does not match expected: 126',
                      contextualizing_variables={'cid': 100, 'user_acctid': 180, 'userid': 175, 
                                                 'user_tier': 'Tier1', 
                                                 'search_engine': 'Google Adwords'}
              				)]
              
              	# this test would fail as without mocking, 
                  # FailedAdInstanceIdsFinder will end up making a database query
                  def test_validator_with_failed_adinstids(self, mock_logger):
                      validation_runner = AdExecuteValidationProcessRunner(userid=175)
              
                      validation_runner.run()
              
                      row = self.failed_adinstance
              
                      mock_logger.error.assert_called_once_with(
                          '[FailedAdInstanceIdsFinder] Bid push had failed '
              			'because actual: 125 does not match expected: 126 '
                          'for adinstid = {} cid = {} search_engine = "{}" '
              			'user_acctid = {} user_tier = {} userid = {}'
                          .format(row['adinstid'], row['cid'], row['search_engine'],
                                  row['user_acctid'], row['user_tier'], row['userid'])
                      )
              ```
        - Good Example
          collapsed:: true
            - ```python
              @mock.patch.object(AdExecuteValidationProcessRunner, '_logger')
              class TestAdExecuteValidator(unittest.TestCase):
                  adinstances = [
                      {'adinstid': 1, 'cid': 100, 'user_acctid': 180, 'userid': 175,
                       'search_engine': 'Google Adwords', 'user_tier': 'Tier1'},
                      {'adinstid': 2, 'cid': 102, 'user_acctid': 181, 'userid': 175,
                       'search_engine': 'MSN adCenter', 'user_tier': 'Tier1'},
                      {'adinstid': 3, 'cid': 104, 'user_acctid': 182, 'userid': 175,
                       'search_engine': 'Google Adwords', 'user_tier': 'Tier1'}
                  ]
                  failed_adinstance = adinstances[0]
                  failures = [FailureInformation(
              		failed_adinstance['adinstid'], 'adinstid', 'FailedAdInstanceIdsFinder',
              		'Bid push had failed because actual: 125 does not match expected: 126',
              		contextualizing_variables={'cid': 100, 'user_acctid': 180, 'userid': 175, 
              								   'user_tier': 'Tier1',
              								   'search_engine': 'Google Adwords'}
              				)]
              
              	# Mocking ensures you have control over the output of FailedAdInstanceIdsFinder. 
              	# This grants you simplicity and effective code coverage.
                  @mock.patch.object(FailedAdInstanceIdsFinder, 'get_failures', return_value=failures)
                  def test_validator_with_failed_adinstids(self, _, mock_logger):
                      validation_runner = AdExecuteValidationProcessRunner(userid=175)
              
                      validation_runner.run()
              
                      row = self.failed_adinstance
              
                      mock_logger.error.assert_called_once_with(
                          '[FailedAdInstanceIdsFinder] Bid push had failed '
              			'because actual: 125 does not match expected: 126 '
                          'for adinstid = {} cid = {} search_engine = "{}" '
              			'user_acctid = {} user_tier = {} userid = {}'
                          .format(row['adinstid'], row['cid'], row['search_engine'],
                                  row['user_acctid'], row['user_tier'], row['userid'])
                      )
              
              # And FailedAdInstanceIdsFinder should be tested in a separate Unit Test class
              
              ```
        - > **WARNING**: Beware of mocking the internal or private methods of a class. It can lead to some area of your code that's uncovered by the unit tests. If you feel writing a test case is difficult without mocking an internal or a private method, then may be your class is catering to too many concerns and is a valid candidate for decomposing into smaller objects.
        - ### What to mock
            - #### Database Queries
                - Pull database Queries out of your object and mock that function.
                - Sample Code
                  collapsed:: true
                    - ```python
                      class ConversionUploadObservabilityConstantsStore(object):
                      	def initialize_process_wide_constants(self, userid):
                              self.__userid = userid
                              self.__user_tier = get_user_tier(userid)  # database query
                      		# ... other details omitted out for brevity
                      
                      def get_user_tier(userid):
                          # type: (int) -> str
                          db = DBWrapper.get_user_timezone_aware_connection(userid)
                          query = 'SELECT user_tier FROM users WHERE userid = {};'.format(userid)
                          return db.query(query).dictresult()[0]['user_tier']
                      
                      ```
                - Mocking
                  collapsed:: true
                    - ```python
                      # since the query is moved to a different function, it's easy to mock
                      @mock.patch(get_user_tier, return_value='Tier1')  
                      class TestConversionUploadProcessWideConstants(unittest.TestCase):
                      
                          def test_initialize_constants(self, *_):
                              ObservabilityConstantsStore.initialize_process_wide_constants(userid=3085)
                      
                              constants = ObservabilityConstantsStore.get_process_wide_constants() 
                      		# ...assert whatever needs to be asserted  
                      ```
            - #### Network Interactions
                - Similar to Database Queries, they also need to be pulled out as a separate function and mocked.
                - Example
                  collapsed:: true
                    - ```python
                      class TestSearchEngineConversionTrackerExistenceChecker(unittest.TestCase):
                      	conversion_trackers = [
                              ConversionTracker(1, 'ACS_OBJ_3_1700000252_180'),
                              ConversionTracker(2, 'ACS_OBJ_3_1700000253_17532'),
                          ]
                      
                           def test_conversion_tracker_existence_checker__existing_tracker_case(self):
                              mock_se_obj = mock.MagicMock(  
                                  get_conversions=mock.MagicMock(
                                      return_value=self.conversion_trackers  # ensuring `get_conversions` returns some conversion trackers
                                  )
                              )
                              with mock.patch.object(SearchEngineObjectRetriever, 'get_se_obj', return_value=mock_se_obj):
                                  irrelevant_param = {'user_acctid': 1700000002, 'sid': 3, 'se_acctid': '180', 'login': '',
                                                      'password': '', 'conversion_manager_se_id': '', 'userid': 1, 'access_key': '',
                                                      'se_api_params': {}}  # type: UserAccount
                                  tracker_exists = SearchEngineConversionTrackerExistenceChecker().check_conversion_tracker_exists(
                                      irrelevant_param, 'ACS_OBJ_3_1700000252_180')
                                  self.assertTrue(tracker_exists)
                      
                          def test_conversion_tracker_existence_checker__non_existing_tracker_case(self):
                              mock_se_obj = mock.MagicMock(
                                  get_conversions=mock.MagicMock(
                                      return_value=[]  # ensuring `get_conversions` returns empty list
                                  )
                              )
                      
                              with mock.patch.object(SearchEngineObjectRetriever, 'get_se_obj', return_value=mock_se_obj):
                                  irrelevant_param = {'user_acctid': 1700000002, 'sid': 3, 'se_acctid': '180', 'login': '',
                                                      'password': '', 'conversion_manager_se_id': '', 'userid': 1, 'access_key': '',
                                                      'se_api_params': {}}
                                  tracker_exists = SearchEngineConversionTrackerExistenceChecker().check_conversion_tracker_exists(
                                      irrelevant_param, 'ACS_OBJ_3_1700000252_180')
                                  self.assertFalse(tracker_exists)
                      ```
            - #### Interactions with other objects or functions outside of the class
                - Mock them too, to test the object in isolation.
- # 5.   Principles of Good Code
    - In essence, there are only two guiding forces to write good code:
    - ## 5.1.  Abstraction
        - Abstraction is **suppression** of **implementation** details to make the **intention** more **prominent**.
    - ## 5.2.  Discipline
        - Discipline means to limit choices in return for simplicity
    - ---
    - But for the sake of expansion and explanation, we have some principles which demonstrate these two guiding forces.
    - ## 5.3.   Summarization
        -
    - ## 5.4.  Decomposition
    - ## 5.5.   Encapsulation
        - You can also think of encapsulation as "don't form direct dependency other's nitty gritties"
    - ## 5.6.   Variation Management
        -
    -