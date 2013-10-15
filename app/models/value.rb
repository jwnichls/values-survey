class Value < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :val_01,:val_02,:val_03,:val_04,:val_05,:val_06,:val_07,:val_08,:val_09,:val_10,:val_11,:val_12, :val_13,:val_14,:val_15,:val_16,:val_17,:val_18, :val_19,:val_20,:val_21,:val_22


  VALUES_Q_M = [
                ["01", "Thinking up new ideas and being creative is important to him. He likes to do things in his own original way."],
                ["02", "It is important to him to be rich. He wants to have a lot of money and expensive things."],
                ["03", "He thinks it is important that every person in the world be treated equally. He wants justice for everybody, even for people he doesn't know."],
                ["04", "It is very important to him to show his abilities. He wants people to admire what he does."],
                ["05", "It is important to him to live in secure surroundings. He avoids anything that might endanger his safety."],
                ["06", "He likes surprises and is always looking for new things to do. He thinks it is important to do lots of different things in life."],
                ["07", "He believes that people should do what they're told. He thinks people should follow rules at all times, even when no-one is watching."],
                ["08", "It is important to him to listen to people who are different from him. Even when he disagrees with them, he still wants to understand them."],
                ["09", "He thinks it's important not to ask for more than what you have. He believes that people should be satisfied with what they have."],
                ["10", "Having a good time is important to him. He likes to ""spoil"" himself."],
                ["11", "It is important to him to make his own decisions about what he does. He likes to be free to plan and to choose his activities for himself."],
                ["12", "It's very important to him to help the people around him. He wants to care for other people."],
                ["13", "Being very successful is important to him. He likes to impress other people."],
                ["14", "It is very important to him that his country be safe from threats from within and without. He is concerned that social order be protected."],
                ["15", "He looks for adventures and likes to take risks. He wants to have an exciting life."],
                ["16", "It is important to him always to behave properly. He wants to avoid doing anything people would say is wrong."],
                ["17", "It is important to him to be in charge and tell others what to do. He wants people to do what he says."],
                ["18", "It is important to him to be loyal to his friends. He wants to devote himself to people close to him."],
                ["19", "He strongly believes that people should care for nature. Looking after the environment is important to him."],
                ["20", "Religious belief is important to him. He tries hard to do what his religion requires."],
                ["21", "He seeks every chance he can to have fun. It is important to him to do things that give him pleasure."],
                ["22", "It is important to him to listen to people who are different from him. Even when he disagrees with them, he still wants to understand them."]              
              ]

  VALUES_Q_F = [
                ["01", "Thinking up new ideas and being creative is important to her. She likes to do things in her own original way."],
                ["02", "It is important to her to be rich. She wants to have a lot of money and expensive things."],
                ["03", "She thinks it is important that every person in the world be treated equally. She wants justice for everybody, even for people she doesn't know."],
                ["04", "It is very important to her to show her abilities. She wants people to admire what she does."],
                ["05", "It is important to her to live in secure surroundings. She avoids anything that might endanger her safety."],
                ["06", "She likes surprises and is always looking for new things to do. She thinks it is important to do lots of different things in life."],
                ["07", "She believes that people should do what they're told. She thinks people should follow rules at all times, even when no-one is watching."],
                ["08", "It is important to her to listen to people who are different from her. Even when she disagrees with them, she still wants to understand them."],
                ["09", "She thinks it's important not to ask for more than what you have. She believes that people should be satisfied with what they have."],
                ["10", "Having a good time is important to her. She likes to ""spoil"" herself."],
                ["11", "It is important to her to make her own decisions about what she does. She likes to be free to plan and to choose her activities for herself."],
                ["12", "It's very important to her to help the people around her. She wants to care for other people."],
                ["13", "Being very successful is important to her. She likes to impress other people."],
                ["14", "It is very important to her that her country be safe from threats from within and without. She is concerned that social order be protected."],
                ["15", "She looks for adventures and likes to take risks. She wants to have an exciting life."],
                ["16", "It is important to her always to behave properly. She wants to avoid doing anything people would say is wrong."],
                ["17", "It is important to her to be in charge and tell others what to do. She wants people to do what she says."],
                ["18", "It is important to her to be loyal to her friends. She wants to devote herself to people close to her."],
                ["19", "She strongly believes that people should care for nature. Looking after the environment is important to her."],
                ["20", "Religious belief is important to her. She tries hard to do what her religion requires."],
                ["21", "She seeks every chance she can to have fun. It is important to her to do things that give her pleasure."],
                ["22", "It is important to her to listen to people who are different from her. Even when she disagrees with them, she still wants to understand them."]              
              ]

end
