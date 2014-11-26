class Player < ActiveRecord::Base

	serialize :player_cards, Array

	belongs_to :game
	belongs_to :user

  # def initialize
  #   super
  #   self.cards_count = 0
  # end

 # def put_card _card
 #  if self.cards_count > 0
 #   self.cards_count -= 1
 #   for i in self.player_cards do
 #    if self.player_cards[i].rang == _card.rang && self.player_cards[i].suite == _card.suite
 #     self.player_cards.delete_at i
 #    end
 #   end
 #  else
 #   puts 'Empty'
 #  end
 # end

  def put_card(_card_id)
    if self.game.put_card_on_table self.player_cards[_card_id] then
      self.player_cards.delete_at _card_id
      self.cards_count -= 1
    end
  end

 def init
  if !self.cards_count
    self.cards_count = 0
  end
 end

 def add_card new_card
  init
  self.player_cards.push new_card
  self.cards_count  += 1
 end
end
