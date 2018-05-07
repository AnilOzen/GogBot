
class Person
{
  String name;
  Emotion currentEmotion;  
  Person(Emotion initialEmotion, String inputName)
  {
    name = inputName;
    currentEmotion = initialEmotion;
  }
  
  Emotion getEmotion()
  {
    return currentEmotion;
  }
  
  void updateEmotion(Emotion newEmotion)
  {
    currentEmotion = newEmotion;
  }
}

class personDuo
{
  Emotion resolvedEmotion;
  personDuo(Person otherperson1, Person otherperson2)
  {
    Emotion emotion1 = otherperson1.getEmotion();
    Emotion emotion2 = otherperson2.getEmotion();
    
    Emotion combinedEmotion = new Emotion("confused");

  }
  
}


class Network
{

}