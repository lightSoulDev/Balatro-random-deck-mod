--- STEAMODDED HEADER
--- MOD_NAME: Random Deck
--- MOD_ID: random_deck
--- PREFIX: random_deck
--- MOD_AUTHOR: [@your_fetish]
--- MOD_DESCRIPTION: Random Deck mod.
--- VERSION: 1.0.0
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Back {
    key = 'random_deck',
    name = "Random Deck",
    stake = 1,
    unlocked = true,
    order = 16,
    pos = { x = 2, y = 3},
    set = "Back",
    config = {
        jokers = {
        },
    },
    discovered = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    local _rank = nil
                    local _suit = nil

                    if G.DEBUG_SEED and string.sub(G.DEBUG_SEED, 1, 4) == 'RAND' then
                        local _eproc = string.sub(G.DEBUG_SEED, 5, 5)
                        if tonumber(_eproc) then
                            G.GAME.RAND_EPROC = tonumber(_eproc)
                        end
                        _rank = string.sub(G.DEBUG_SEED, 6, 6)
                        _suit = string.sub(G.DEBUG_SEED, 7, 7)
                        if not G.P_CARDS[_suit .. '_' .._rank] then
                            if G.P_CARDS['H' .. '_' .._rank] then
                                _suit = nil
                            elseif G.P_CARDS[_suit .. '_' ..'2'] then
                                _rank = nil
                            else
                                _suit = nil
                                _rank = nil
                            end
                        end
                    end

                    _rank = _rank or pseudorandom_element({'2','3','4','5','6','7','8','9','T','J','Q','K','A'}, pseudoseed('random_deck'))
                    _suit = _suit or pseudorandom_element({'S','H','C','D'}, pseudoseed('random_deck'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'

                    v:set_base(G.P_CARDS[_suit .. '_' .._rank])
                end
            return true
            end
        }))
    end
}