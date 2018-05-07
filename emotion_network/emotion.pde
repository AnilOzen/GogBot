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
  Emotion[][] emotionTable;
  EmotionMatrix()
  {
    emotionTable = new Emotion[5][5];
    /*
    emotionTable = {
      {},
      {},
      {},
      
    };
    */
  }
  
}