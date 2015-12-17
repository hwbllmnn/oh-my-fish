function describe_plugin_install
  function before_all
    set -gx CI WORKAROUND
  end

  function before_each
    omf uninstall basename-compat >/dev/null 2>&1
  end

  function it_does_nothing_when_no_argument_is_specified
    set -l output (omf install)
    assert "" = "$output"
  end

  function it_prints_a_success_message_if_a_plugin_is_installed
    set -l output (omf install basename-compat)
    echo $output | grep -q "successfully installed"

    assert 0 = $status; or echo $output
  end

  function it_returns_success_if_a_plugin_is_installed
    set -l output (omf install basename-compat)
    assert 0 = $status; or echo $output
  end

  function it_prints_an_error_message_if_an_invalid_plugin_is_specified
    set -l output (omf install invalid-plugin 2>&1)
    echo $output | grep -q "Could not install package"

    assert 0 = $status; or echo $output
  end

  function it_returns_an_error_if_an_invalid_plugin_is_specified
    set -l output (omf install invalid-plugin)
    assert 1 = $status; or echo $output
  end
end
