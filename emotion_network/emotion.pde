//representative class for each emotion
class Emotion 
{
  String description;
  int indexNumber;
  Emotion(String initEmotion, int initIndexNumber)
  {
    indexNumber = initIndexNumber;
    description = initEmotion;
  }
  String getEmotion()
  {
    return description;
  }
}

//Too lazy to write a parser
//hard code for now
class EmotionMatrix
{
  String[][] emotionTable;

  EmotionMatrix()
  {
    emotionTable = new String[5][5];
    String[][] inputs = {
      {"angry","funny","neutral","sad","happy"},
      {"funny","neutral","sad","angry","happy"},
      {"1","2","3","4","5"},
      {"6","7","8","9","10"},
      {"11","12","13","14","sad"}
    };
    for (int i=0; i<5; i++)
      for (int j=0; j<5; j++)
      {
        emotionTable[i][j] = inputs[i][j];
        print(emotionTable[i][j], " ");
      }
      
  }
  
  void printValues()
  {
    for (int i=0; i<5; i++)
      for (int j=0; j<5; j++)
      {
        print(emotionTable[i][j]);
      }
      print("\n");  
  }
  
  
  
}