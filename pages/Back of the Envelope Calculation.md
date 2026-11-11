public:: true
filters:: {"templates" false}
type::
alias::
tags:: System Design

- step 1
    - RPS (requests ) <- server capacity
    - QPS (Queries), TPS (Transactions) <- database capacity
- # RPS -> Server Capacity
    - Process:
    - <div style="display: flex;"> 
      <div> Users</div> 
      <div> --> </div> 
      <div> RPS </div>
    - <div> --> </div>
      <div> Capacity</div>
      </div>
-
- First input:
    - **DAU**, MAU
    - typical number of requests per session (estimate what all api's will be hit in a typical user's session, in a day) -
- From Users's to capacity:
    - <div style="display: flex;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> DAU</div> 
      <div style="padding: 20px; font-size: 25px;"> x </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> requests/user/day</div>
      <div style="padding: 20px; font-size: 25px;"> / </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> divide by 86400</div>
      <div style="padding: 20px; font-size: 25px;"> = </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <b>avg rps</b></div>
      </div>
    - or
    - <div style="display: flex;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> MAU</div> 
      <div style="padding: 20px; font-size: 25px;"> x </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> requests/user/month</div>
      <div style="padding: 20px; font-size: 25px;"> / </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> divide by 2.5million</div>
      <div style="padding: 20px; font-size: 25px;"> = </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <b>avg rps</b></div>
      </div>
    - avg rps x peak factor(2-20) = **Peak RPS**
- RPS to capacity:
    - inputs:
        - Read/write ratio
        - Requests in flight ()
- <div style="display: flex;"> 
  <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> Peak RPS</div> 
  <div style="padding: 20px; font-size: 25px;"> / </div> 
  <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> per node peak RPS</div>
  <div style="padding: 20px; font-size: 25px;"> x </div> 
  <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> 0.7 </div>
  <div style="padding: 20px; font-size: 25px;"> = </div> 
  <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <b>No. of Servers</b></div>
  </div>
- per node = 500 rps
- 7000 peak rps
-
- 7000 / (50 * 7) = 1000/50 = 20 servers
- # Storage requirement
    - <div style="display: flex;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> Writes / day</div> 
      <div style="padding: 20px; font-size: 25px;"> x </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> bytes/record</div>
      <div style="padding: 20px; font-size: 25px;"> x </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> days kept</div>
      <div style="padding: 20px; font-size: 25px;"> x </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> replicas</div>
      <div style="padding: 20px; font-size: 25px;"> = </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> storage</div>
      </div>
    - Cache the hot 20% 0.2Xdaily read set
        - data read in queries daily?