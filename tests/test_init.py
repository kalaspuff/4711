import _4711


def test_init():
    assert _4711

    assert isinstance(_4711.__version_info__, tuple)
    assert _4711.__version_info__
    assert isinstance(_4711.__version__, str)
    assert len(_4711.__version__)
