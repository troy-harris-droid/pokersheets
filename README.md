# Pokersheets
Online Poker with [Google Spreadsheets API](https://developers.google.com/sheets/api/reference/rest) inspired by "The Event"

### **Pre-requistes:** 
- Ruby

### Setup:
1) git clone git@github.com:troy-harris-droid/pokersheets.git  
2) cd ./pokersheets  
3) bundle  
4) Update [Googlsheets.rb](https://github.com/troy-harris-droid/pokersheets/blob/7cddcf00c306ab595439b00886a4ae2c3d3885ba/googlesheets.rb#L16) to use your Spreadsheet_ID  
5) Update [Googlesheets.rb](https://github.com/troy-harris-droid/pokersheets/blob/7cddcf00c306ab595439b00886a4ae2c3d3885ba/googlesheets.rb#L56) worksheet name  
6) ruby run.rb  
7) Allow permissions to your Spreadsheet  
  
**Expect:** Output to console, cells updated  

### TODO:
- Write to multiple sheets(players)
- Test gameplay (does this actually work with humans)
- Swap card names for card images on sheet? ♥️🃏
