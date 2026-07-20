- #[[Career Learnings]]
- While joining a new place:
    - Does product manager join the standups?
        - To understand the collaboration between the Tech and Product. May be due to timezone difference, the communication is patchy.
- While interviewing a candidate
    - LLD
        - Design a Conversions Upload system
        - # Context
        - E-commerce websites generally track a potential customer's journey from the click on an ad till the purchase made (also called a "conversion", which is a more general term).
          Therefore analytics platforms, that are utilized for this data collection, generate data for each conversion in this format:
          
          | click id             | conversion timestamp     | conversion value |
          | -------------------- | ------------------------ | ---------------- |
          | some_long_random_str | 2024-08-01 12:35:12+0000 | 84.3             |
        - # Problem statement
            - The conversion data mentioned above is stored in csv format in the disk. New files are generated at a cadence of an hour, let's say.
              This is the format of the file names:
            - `/data/conversion_files/20240815/conversions_1346_1600004_20240815223000`
            - Design a Conversion Data Upload system which is expected to run every 3 hours and takes these inputs:
                - `userid`
            - And fulfills these expectations:
                - 1. Picks up all the conversion files from the disk for the current date (utility function is provided). Ch
                - 2. Determines the Correct action to perform against a file, either uploading the conversion data within or create the non-existent conversion action
                - 3. (only if there's time) uploads the conversion data contained within the files to the Advertisement Platform or creates the missing conversion action
            - LLD -> obj public methods, type of parameters , return types , interfaces
            - Skeleton:
                - ```python
                  # Entities
                  
                  class User:
                      userid: int
                      client_name: str
                      
                  
                  class UserAccount:
                      user: User
                      user_acctid: int
                      login_id: str
                      password: str
                      ad_platform: AdvertisementPlatform  # enum with two values 'Google Ads' and 'Bing Ads'
                      account_name: str
                      
                      def getConversionAction():
                          pass
                  
                  class ConversionAction:
                      user_account: UserAccount
                      name: str  # AUTO_ACTION_{user_acctid}
                  
                  class ConversionFeed:  # corresponds to each row in the conversion files
                      conversion_action: ConversionAction
                      click_id: str
                      conversion_timestamp: datetime # timestamp with timezone
                      conversion_value: Decimal
                      
                  
                  # Utilities provided
                  
                  
                  class AdvertisementPlatform:  # interface
                      def login(login_id: str, password: str):
                          pass
                          
                      def login_with_account(user_account: UserAccount):
                          # convenient wrapper over login()
                          pass
                  
                      def get_conversion_actions() -> list[ConversionAction]:
                          pass
                      
                      def upload_conversion_feeds(conversion_feeds: list[ConversionFeed]) -> list[ConversionFeed]:
                          pass
                  
                      def create_conversion_actions(conversion_actions: list[ConversionAction]) -> list[ConversionAction]:
                          pass
                      
                      
                  
                  
                  class GoogleAds(AdvertisementPlatform):
                      # provides implementation
                      pass
                  
                  class BingAds(AdvertisementPlatform):
                      pass
                      
                  
                  
                  
                  # --- #
                  import glob
                  
                  def get_existent_file_names_of(file_path_pattern: str) -> list[str]:
                      # similar to doing `ls` on terminal. Can be used to fetch a list of files of a user
                      # get_existent_file_names_of('/data/conversion_files/conversions_1346*')
                      # returns something like ['/data/conversion_files/20240815/conversions_1346_1600004_20240815223000', ...]
                      
                      return glob.glob(file_path_pattern) 
                  
                  
                  def get_conversion_action_name(user_acctid: int) -> str:
                      return f'AUTO_ACTION_{user_acctid}'
                    
                    
                  class ConversionDataUploadProcessRunner(object):
                      __some_dependency = None # don't worry about constructor injection
                      
                      def run_process(self, userid: int) -> None:
                          # Entry point
                          pass
                  ```