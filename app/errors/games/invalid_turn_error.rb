module Games
  class InvalidTurnError < Base
    def message
      I18n.t('api.games.errors.invalid_turn')
    end
  end
end