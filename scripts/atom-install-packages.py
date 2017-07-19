#! /usr/bin/env python
import os
import subprocess
import re

ATOM_PACKAGES_FILE_NAME = 'atom-packages.txt'


class PackageInfo:
    PACKAGE_RE = re.compile('(?P<name>.+)@(?P<major>\d+)\.(?P<minor>\d+)\.(?P<patch>\d+)')

    def __init__(self, package_str):
        self.as_str = package_str
        self.name, self.ver_str = package_str.split('@')

        match_dict = re.match(self.PACKAGE_RE, package_str).groupdict()

        self.ver_as_int = 0
        for ver_part in ['major', 'minor', 'patch']:
            self.ver_as_int = self.ver_as_int * 1000 + int(match_dict.get(ver_part))

    def __cmp__(self, other):
        if isinstance(other, self.__class__):
            return self.ver_as_int - other.ver_as_int
        return NotImplemented

    def __str__(self):
        return '{0.__class__.__name__}[{0.as_str} / {0.ver_as_int}]'.format(self)


def strings_list_to_packages_dict(list_of_str):
    """ Makes dict of PackageInfo objects from list of strings, ignore empty strings """
    hash = {}
    for pack_str in list_of_str:
        pack_str = pack_str.strip()
        # language-html - is hanlded in other way so skip it here
        if pack_str and not pack_str.startswith('language-html'):
            pack = PackageInfo(pack_str)
            hash[pack.name] = pack
    return hash


def get_installed():
    installed_packages_output = subprocess.check_output('apm list --installed --bare'.split(' '))
    return strings_list_to_packages_dict(installed_packages_output.split('\n'))


def get_required():
    atom_packages_path = os.path.join(os.path.dirname(__file__), ATOM_PACKAGES_FILE_NAME)
    return strings_list_to_packages_dict(open(atom_packages_path).readlines())


def run():
    required = get_required()
    installed = get_installed()
    cmd_template = 'apm install {0}'

    for req_pack_name, req_pack in required.iteritems():
        inst_pack = installed.get(req_pack_name, None)
        need_install = False

        if inst_pack is None:
            need_install = True
            status = 'INSTALLING NEW PACKAGE...'
        elif inst_pack == req_pack:
            status = 'skipping. already installed'
        elif inst_pack < req_pack:
            need_install = True
            status = 'UPDATING {0} -> {1}...'.format(inst_pack.ver_str, req_pack.ver_str)
        else:
            status = 'skipping. WARNING!!! local version is newer. Please resolve it manually'

        print('{0:<40} {1}'.format(req_pack.as_str, status))
        if need_install:
            print(cmd_template.format(req_pack.as_str))
            subprocess.check_call(cmd_template.format(req_pack.as_str).split(' '))

    inst_set = set(installed.keys())
    req_set = set(required.keys())
    not_required_anymore = inst_set.difference(req_set)
    if not_required_anymore:
        print('\nWarning!!! Following packages are not presented in "{0}" but locally insalled :\n\t{1}'.format(
            ATOM_PACKAGES_FILE_NAME,
            '\n\t'.join(list(not_required_anymore))
        ))
    extra_cmd = 'apm install rodmax/language-html-custom'
    print(extra_cmd)
    subprocess.check_call(extra_cmd.split(' '))


if __name__ == '__main__':
    run()
