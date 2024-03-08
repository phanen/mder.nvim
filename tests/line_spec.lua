local tl = require("mder.line").toggle_line

describe("line tests", function()
  local asserter = function(tests)
    return function()
      for _, test in ipairs(tests) do
        if test[3] then
          assert.same(test[2], tl(test[1]))
        else
          assert.is_not.same(test[2], tl(test[1]))
        end
      end
    end
  end

  it(
    "toggle empty",
    asserter {
      { "", "* ", true },
      { "  ", "  * ", true },
    }
  )

  it(
    "toggle non-empty",
    asserter {
      { "raw line", "* raw line", true },
      { "* item line", "* [ ] item line", true },
      { "+ [ ] box line", "+ [x] box line", true },
      { "- [x] box line", "- [ ] box line", true },
    }
  )

  it(
    "list symbol in sentence",
    asserter {
      { "c++ sucks", "* c++ sucks", true },
      { "* c++ sucks", "* [ ] c++ sucks", true },
      { "* [ ] c++ sucks", "* [x] c++ sucks", true },
    }
  )

  it(
    "keep indent",
    asserter {
      { "  aaa", "  * aaa", true },
      { "    aaa", "    * aaa", true },
    }
  )
end)
